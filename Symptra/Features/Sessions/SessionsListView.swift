//
//  SessionsListView.swift
//  Symptra
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SessionsListView: View {
    @Bindable var appModel: AppViewModel
    @State private var sessions: [IdentifiedSession] = []
    @State private var listener: ListenerRegistration?
    @State private var activeInterview: InterviewViewModel?
    @State private var showInterview = false
    @State private var savedReportHTML: String?
    @State private var showReport = false

    var body: some View {
        NavigationStack {
            List {
                if sessions.isEmpty {
                    ContentUnavailableView(
                        "No sessions yet",
                        systemImage: "doc.text",
                        description: Text("Start a questionnaire from Home.")
                    )
                }
                ForEach(sessions) { item in
                    Button {
                        handleTap(item)
                    } label: {
                        SessionRowView(session: item)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Sessions")
            .task { attachListener() }
            .onDisappear { listener?.remove() }
            .fullScreenCover(isPresented: $showInterview, onDismiss: {
                activeInterview = nil
            }) {
                if let vm = activeInterview {
                    InterviewFlowView(interview: vm)
                }
            }
            .sheet(isPresented: $showReport) {
                NavigationStack {
                    if let html = savedReportHTML {
                        ReportWebView(html: html)
                            .navigationTitle("Report")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Done") { showReport = false }
                                }
                            }
                    }
                }
            }
        }
    }

    private func attachListener() {
        guard let uid = appModel.firebaseUser?.uid else { return }
        listener?.remove()
        listener = SessionFirestoreService().listenSessions(uid: uid) { items in
            sessions = items
        }
    }

    private func handleTap(_ item: IdentifiedSession) {
        if item.data.status == SessionDocument.Status.completed,
           let b64 = item.data.reportHTMLDataBase64,
           let data = Data(base64Encoded: b64),
           let html = String(data: data, encoding: .utf8)
        {
            savedReportHTML = html
            showReport = true
            return
        }
        guard let uid = appModel.firebaseUser?.uid,
              let profile = appModel.profile,
              let vm = InterviewViewModel(
                sessionService: SessionFirestoreService(),
                uid: uid,
                userProfile: profile
              )
        else { return }
        activeInterview = vm
        showInterview = true
        Task { await vm.resume(from: item) }
    }

    private func delete(at offsets: IndexSet) {
        guard let uid = appModel.firebaseUser?.uid else { return }
        for i in offsets {
            let id = sessions[i].id
            Task {
                try? await SessionFirestoreService().deleteSession(uid: uid, id: id)
            }
        }
    }
}

private struct SessionRowView: View {
    let session: IdentifiedSession

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                StatusDot(status: session.data.status, stage: session.data.pipelineStage)
                Text(title)
                    .font(.headline)
            }
            Text(session.data.chiefComplaintText ?? "Health questionnaire")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Text(session.data.updatedAt.dateValue(), style: .relative)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }

    private var title: String {
        switch session.data.status {
        case SessionDocument.Status.completed:
            return "Completed"
        default:
            return session.data.pipelineStage == SessionDocument.PipelineStage.interviewing ? "In progress" : "Setup"
        }
    }
}

private struct StatusDot: View {
    let status: String
    let stage: String

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
    }

    private var color: Color {
        if status == SessionDocument.Status.completed { return .green }
        if stage == SessionDocument.PipelineStage.interviewing { return .yellow }
        return .orange
    }
}
