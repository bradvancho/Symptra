//
//  IMHInterviewService.swift
//  Symptra
//

import Foundation
import OSLog

/// Configures an encounter and runs the question loop (hypermedia-driven).
final class IMHInterviewService: @unchecked Sendable {
    private let client: IMHAPIClient

    init(client: IMHAPIClient) {
        self.client = client
    }

    convenience init?() {
        guard let client = IMHAPIClient() else { return nil }
        self.init(client: client)
    }

    // MARK: - Discover & create

    func createEncounter() async throws -> (encounterId: String, links: [APILinkDTO]) {
        let rootData = try await client.data(method: "GET", url: AppConfiguration.imhRootURL)
        let links = try Self.decodeRootLinks(data: rootData, client: client)
        guard let postURLString = links.link(resource: "encounters")?.url,
              let postURL = URL(string: postURLString)
        else {
            throw IMHAPIError.invalidURL
        }
        let created = try await client.data(method: "POST", url: postURL, body: nil)
        let decoded = try client.decode(EncounterCreateResponse.self, from: created)
        try IMHAPIClient.checkApiStatus(decoded.apiStatus)
        guard let enc = decoded.encounter, !enc.encounterId.isEmpty else {
            throw IMHAPIError.emptyBody
        }
        return (enc.encounterId, enc.apiLinks)
    }

    // MARK: - Configure

    func putSettings(encounterId: String, links: [APILinkDTO]) async throws -> [APILinkDTO] {
        guard let link = links.link(resource: "settings") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let getData = try await client.data(method: "GET", url: url)
        let merged = try IMHJSONMutations.mergeSettingsQuestionForm(
            data: getData,
            namespaceRoot: AppConfiguration.imhNamespaceRoot
        )
        let putData = try await client.data(method: "PUT", url: url, body: merged)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    func putPatient(encounterId: String, links: [APILinkDTO], dateOfBirth: Date, genderCode: String) async throws -> [APILinkDTO] {
        guard let link = links.link(resource: "patient") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let getData = try await client.data(method: "GET", url: url)
        let merged = try IMHJSONMutations.mergePatient(data: getData, dateOfBirth: dateOfBirth, genderCode: genderCode)
        let putData = try await client.data(method: "PUT", url: url, body: merged)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    func putProvider(encounterId: String, links: [APILinkDTO]) async throws -> [APILinkDTO] {
        guard let link = links.link(resource: "provider") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let getData = try await client.data(method: "GET", url: url)
        let merged = try IMHJSONMutations.mergeProviderPlaceholder(data: getData)
        let putData = try await client.data(method: "PUT", url: url, body: merged)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    func putChiefComplaint(encounterId: String, links: [APILinkDTO], text: String) async throws -> [APILinkDTO] {
        guard let link = links.link(resource: "chiefcomplaint") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let body = try IMHJSONMutations.chiefComplaintBody(text: text)
        let putData = try await client.data(method: "PUT", url: url, body: body)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    func putQuestionnaireQueue(encounterId: String, links: [APILinkDTO], symptomNames: [String]) async throws -> [APILinkDTO] {
        guard let link = links.link(resource: "questionnairequeue") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let body = try IMHJSONMutations.questionnaireQueueBody(names: symptomNames)
        let putData = try await client.data(method: "PUT", url: url, body: body)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    // MARK: - Questions

    func getCurrentQuestion(encounterId: String, links: [APILinkDTO]) async throws -> QuestionResponseDTO {
        guard let link = links.link(resource: "question") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let data = try await client.data(method: "GET", url: url)
        return try client.decode(QuestionResponseDTO.self, from: data)
    }

    func putAnswer(encounterId: String, links: [APILinkDTO], questionId: String, answerMap: [String: Any]) async throws -> [APILinkDTO] {
        let url = try Self.patientAnswerURL(links: links, encounterId: encounterId, questionId: questionId)
        let body = try IMHJSONMutations.patientAnswerBody(answerMap: answerMap)
        let putData = try await client.data(method: "PUT", url: url, body: body)
        return try refreshedLinks(from: putData, encounterId: encounterId, fallback: links)
    }

    private static func patientAnswerURL(links: [APILinkDTO], encounterId: String, questionId: String) throws -> URL {
        if let direct = links.link(resource: "patientanswer") {
            var s = direct.resolvedURL(encounterId: encounterId)
            if !s.contains(questionId) {
                s = s.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                s += "/\(questionId)"
            }
            if let u = URL(string: s) { return u }
        }
        guard let questionLink = links.link(resource: "question") else { throw IMHAPIError.invalidURL }
        let base = questionLink.resolvedURL(encounterId: encounterId)
        guard let range = base.range(of: "/question", options: .backwards) else { throw IMHAPIError.invalidURL }
        let prefix = base[..<range.lowerBound]
        let built = "\(prefix)/patientanswer/\(questionId)"
        guard let url = URL(string: String(built)) else { throw IMHAPIError.invalidURL }
        return url
    }

    // MARK: - Report

    func createHTMLReport(encounterId: String, links: [APILinkDTO]) async throws -> Data {
        guard let link = links.link(resource: "report") else { throw IMHAPIError.invalidURL }
        let url = URL(string: link.resolvedURL(encounterId: encounterId))!
        let body = try IMHJSONMutations.reportRequestBodyHTML()
        return try await client.data(method: "POST", url: url, body: body)
    }

    // MARK: - Links refresh

    private func refreshedLinks(from data: Data, encounterId: String, fallback: [APILinkDTO]) throws -> [APILinkDTO] {
        if let updated = try? client.decode(EncounterCreateResponse.self, from: data),
           let enc = updated.encounter,
           !enc.apiLinks.isEmpty
        {
            try IMHAPIClient.checkApiStatus(updated.apiStatus)
            return enc.apiLinks
        }
        if let wrapper = try? client.decode(EncounterBodyOnly.self, from: data),
           let enc = wrapper.encounter,
           !enc.apiLinks.isEmpty
        {
            return enc.apiLinks
        }
        return fallback
    }

    private static func decodeRootLinks(data: Data, client: IMHAPIClient) throws -> [APILinkDTO] {
        if let r = try? client.decode(IMHRootLinksResponse.self, from: data), let list = r.apiLinks, !list.isEmpty {
            return list
        }
        if let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let list = obj["ApiLinks"] as? [[String: Any]],
           let json = try? JSONSerialization.data(withJSONObject: list),
           let decoded = try? JSONDecoder().decode([APILinkDTO].self, from: json)
        {
            return decoded
        }
        throw IMHAPIError.decoding(NSError(domain: "Symptra", code: 0, userInfo: [NSLocalizedDescriptionKey: "Root links"]))
    }
}

private struct EncounterBodyOnly: Decodable {
    let encounter: EncounterBodyDTO?
    enum CodingKeys: String, CodingKey {
        case encounter = "Encounter"
    }
}
