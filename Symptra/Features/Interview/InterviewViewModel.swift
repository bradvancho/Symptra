//
//  InterviewViewModel.swift
//  Symptra
//

import Foundation
import Observation
import FirebaseFirestore
import OSLog

@MainActor
@Observable
final class InterviewViewModel {
    enum Phase: String {
        case idle, configuring, asking, finished, failed
    }

    var phase: Phase = .idle
    var errorMessage: String?
    var chiefComplaint: String = ""

    private(set) var encounterId: String = ""
    private(set) var links: [APILinkDTO] = []
    private(set) var firestoreSessionId: String?

    private(set) var currentForm: QuestionFormDTO?
    private(set) var currentQuestionId: String?
    /// Editing buffer: variable name → string representation; converted on submit using variable `Type`.
    var answerStrings: [String: String] = [:]

    private var sessionCreatedAt: Timestamp?
    private var persistedReportBase64: String?

    private(set) var reportHTML: String?

    private let service: IMHInterviewService
    private let sessionService: SessionFirestoreService
    private let uid: String
    private let userProfile: UserProfile

    init(
        service: IMHInterviewService,
        sessionService: SessionFirestoreService,
        uid: String,
        userProfile: UserProfile
    ) {
        self.service = service
        self.sessionService = sessionService
        self.uid = uid
        self.userProfile = userProfile
    }

    convenience init?(sessionService: SessionFirestoreService, uid: String, userProfile: UserProfile) {
        guard let svc = IMHInterviewService() else { return nil }
        self.init(service: svc, sessionService: sessionService, uid: uid, userProfile: userProfile)
    }

    /// New interview from symptom text.
    func startNew(symptomText: String) async {
        chiefComplaint = symptomText
        phase = .configuring
        errorMessage = nil
        reportHTML = nil
        sessionCreatedAt = nil
        firestoreSessionId = nil
        persistedReportBase64 = nil
        do {
            let created = try await service.createEncounter()
            encounterId = created.encounterId
            links = created.links
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.encounterCreated)

            links = try await service.putSettings(encounterId: encounterId, links: links)
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.settingsConfigured)

            links = try await service.putPatient(
                encounterId: encounterId,
                links: links,
                dateOfBirth: userProfile.dateOfBirth.dateValue(),
                genderCode: userProfile.genderCode
            )
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.patientConfigured)

            links = try await service.putProvider(encounterId: encounterId, links: links)
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.providerConfigured)

            links = try await service.putChiefComplaint(encounterId: encounterId, links: links, text: symptomText)
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.chiefComplaintSet)

            let tokens = tokenizeComplaint(symptomText)
            links = try await service.putQuestionnaireQueue(encounterId: encounterId, links: links, symptomNames: tokens)
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.queueConfigured)

            try await loadNextQuestion()
        } catch {
            phase = .failed
            errorMessage = error.localizedDescription
            Logger.imh.error("Interview start failed")
        }
    }

    func setAnswerKey(_ key: String, _ value: String) {
        var copy = answerStrings
        copy[key] = value
        answerStrings = copy
    }

    /// Resume from Firestore session.
    func resume(from session: IdentifiedSession) async {
        phase = .configuring
        errorMessage = nil
        reportHTML = nil
        sessionCreatedAt = session.data.createdAt
        encounterId = session.data.encounterId
        links = session.data.apiLinks
        firestoreSessionId = session.id
        chiefComplaint = session.data.chiefComplaintText ?? ""
        persistedReportBase64 = session.data.reportHTMLDataBase64
        do {
            try await loadNextQuestion()
        } catch {
            phase = .failed
            errorMessage = error.localizedDescription
        }
    }

    func submitCurrentQuestion() async {
        guard let qid = currentQuestionId, let form = currentForm else { return }
        phase = .configuring
        errorMessage = nil
        do {
            let map = try buildAnswerMap(form: form)
            links = try await service.putAnswer(encounterId: encounterId, links: links, questionId: qid, answerMap: map)
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.interviewing)
            answerStrings = [:]
            currentForm = nil
            currentQuestionId = nil
            try await loadNextQuestion()
        } catch {
            phase = .asking
            errorMessage = error.localizedDescription
        }
    }

    func generateReport() async {
        phase = .configuring
        errorMessage = nil
        do {
            let data = try await service.createHTMLReport(encounterId: encounterId, links: links)
            if let html = String(data: data, encoding: .utf8), html.contains("<") {
                reportHTML = html
            } else if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let report = json["Report"] as? [String: Any],
                      let content = report["Content"] as? String
            {
                reportHTML = content
            } else {
                reportHTML = String(data: data, encoding: .utf8)
            }
            persistedReportBase64 = reportHTML.flatMap { Data($0.utf8).base64EncodedString() }
            _ = try await persist(stage: SessionDocument.PipelineStage.reportFetched, completed: true)
            phase = .finished
        } catch {
            phase = .failed
            errorMessage = error.localizedDescription
        }
    }

    private func loadNextQuestion() async throws {
        let q = try await service.getCurrentQuestion(encounterId: encounterId, links: links)
        try IMHAPIClient.checkApiStatus(q.apiStatus)
        if let form = q.question?.questionForm {
            currentForm = form
            currentQuestionId = q.questionId
            answerStrings = defaultAnswerStrings(for: form)
            phase = .asking
            firestoreSessionId = try await persist(stage: SessionDocument.PipelineStage.interviewing)
            return
        }
        currentForm = nil
        currentQuestionId = nil
        await generateReport()
    }

    private func defaultAnswerStrings(for form: QuestionFormDTO) -> [String: String] {
        var out: [String: String] = [:]
        for v in form.model.variables {
            switch v.type.lowercased() {
            case "bool":
                out[v.variableName] = "false"
            case "integer":
                out[v.variableName] = "0"
            default:
                out[v.variableName] = ""
            }
        }
        return out
    }

    private func buildAnswerMap(form: QuestionFormDTO) throws -> [String: Any] {
        var map: [String: Any] = [:]
        for v in form.model.variables {
            let raw = answerStrings[v.variableName] ?? ""
            switch v.type.lowercased() {
            case "bool":
                let b = (raw as NSString).boolValue || raw.lowercased() == "true" || raw == "1"
                map[v.variableName] = b
            case "integer":
                guard let i = Int(raw.trimmingCharacters(in: .whitespacesAndNewlines)) else {
                    if v.required == true {
                        throw NSError(domain: "Symptra", code: 1, userInfo: [NSLocalizedDescriptionKey: "Enter a valid number."])
                    }
                    continue
                }
                map[v.variableName] = i
            default:
                if raw.isEmpty, v.required == true {
                    throw NSError(domain: "Symptra", code: 1, userInfo: [NSLocalizedDescriptionKey: "Please answer all required fields."])
                }
                if v.enumValues != nil, !raw.isEmpty {
                    map[v.variableName] = raw
                } else {
                    map[v.variableName] = raw
                }
            }
        }
        return map
    }

    private func persist(stage: String, completed: Bool = false) async throws -> String {
        let now = Timestamp(date: Date())
        let created = sessionCreatedAt ?? now
        sessionCreatedAt = created
        let doc = SessionDocument(
            encounterId: encounterId,
            apiLinks: links,
            apiLinksUpdatedAt: now,
            pipelineStage: stage,
            chiefComplaintText: chiefComplaint.isEmpty ? nil : chiefComplaint,
            status: completed ? SessionDocument.Status.completed : SessionDocument.Status.inProgress,
            interviewCursor: nil,
            createdAt: created,
            updatedAt: now,
            completedAt: completed ? now : nil,
            reportHTMLDataBase64: persistedReportBase64,
            reportSummary: nil
        )
        return try await sessionService.saveSession(uid: uid, id: firestoreSessionId, document: doc)
    }

    private func tokenizeComplaint(_ text: String) -> [String] {
        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if t.isEmpty { return ["general"] }
        return [t]
    }
}
