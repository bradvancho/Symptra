//
//  HomeView.swift
//  Symptra
//

import SwiftUI

struct HomeView: View {
    @Bindable var appModel: AppViewModel
    @State private var showStart = false
    @State private var activeInterview: InterviewViewModel?
    @State private var showInterview = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                VStack(spacing: 8) {
                    Text("Symptra")
                        .font(.title.bold())
                    Text("Welcome back!")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 16) {
                    Image(systemName: "list.clipboard.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.tint)
                    Text("Health assessment")
                        .font(.title2.bold())
                    Text("Start a new questionnaire to assess your current health status.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    Button {
                        showStart = true
                    } label: {
                        Label("Start new questionnaire", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!AppConfiguration.hasIMHCredentials)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))

                if !AppConfiguration.hasIMHCredentials {
                    Text("Add IMH credentials in Config/Secrets.xcconfig to start an interview.")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfileView(appModel: appModel)
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .sheet(isPresented: $showStart) {
                StartQuestionnaireSheet(
                    appModel: appModel,
                    onStart: { symptom, vm in
                        activeInterview = vm
                        showStart = false
                        showInterview = true
                        Task { await vm.startNew(symptomText: symptom) }
                    }
                )
            }
            .fullScreenCover(isPresented: $showInterview, onDismiss: {
                activeInterview = nil
            }) {
                if let vm = activeInterview {
                    InterviewFlowView(interview: vm)
                }
            }
        }
    }
}
