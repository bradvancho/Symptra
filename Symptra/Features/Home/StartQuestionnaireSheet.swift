//
//  StartQuestionnaireSheet.swift
//  Symptra
//

import SwiftUI
import FirebaseAuth

struct StartQuestionnaireSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var appModel: AppViewModel
    var onStart: (String, InterviewViewModel) -> Void

    @State private var symptom = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("What is your main concern?") {
                    TextField("e.g. headache, back pain", text: $symptom, axis: .vertical)
                        .lineLimit(3 ... 6)
                }
                Section {
                    Button("Begin questionnaire") {
                        guard let uid = appModel.firebaseUser?.uid,
                              let profile = appModel.profile,
                              let vm = InterviewViewModel(
                                sessionService: SessionFirestoreService(),
                                uid: uid,
                                userProfile: profile
                              )
                        else { return }
                        let text = symptom.trimmingCharacters(in: .whitespacesAndNewlines)
                        onStart(text.isEmpty ? "general" : text, vm)
                    }
                    .disabled(symptom.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !AppConfiguration.hasIMHCredentials)
                }
            }
            .navigationTitle("New questionnaire")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
