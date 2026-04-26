//
//  InterviewFlowView.swift
//  Symptra
//

import SwiftUI

struct InterviewFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var interview: InterviewViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch interview.phase {
                case .idle, .configuring:
                    ProgressView("Working with interview service…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .failed:
                    VStack(spacing: 16) {
                        Text(interview.errorMessage ?? "Something went wrong.")
                            .multilineTextAlignment(.center)
                        Button("Close") { dismiss() }
                    }
                    .padding()
                case .asking:
                    if let form = interview.currentForm {
                        ScrollView {
                            QuestionFormContentView(form: form, interview: interview)
                                .padding()
                        }
                        .safeAreaInset(edge: .bottom) {
                            Button("Continue") {
                                Task { await interview.submitCurrentQuestion() }
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                            .disabled(interview.phase != .asking)
                        }
                    }
                case .finished:
                    if let html = interview.reportHTML {
                        ReportWebView(html: html)
                            .navigationTitle("Report")
                    } else {
                        Text("Interview complete.")
                    }
                    Button("Done") { dismiss() }
                        .padding()
                }
            }
            .navigationTitle("Questionnaire")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
