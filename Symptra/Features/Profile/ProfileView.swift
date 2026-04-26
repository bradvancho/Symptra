//
//  ProfileView.swift
//  Symptra
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct ProfileView: View {
    @Bindable var appModel: AppViewModel
    @State private var dateOfBirth = Date()
    @State private var genderCode = "M"

    var body: some View {
        Form {
            if let email = appModel.firebaseUser?.email {
                Section("Account") {
                    LabeledContent("Email", value: email)
                }
            }
            Section("Health profile") {
                DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                Picker("Gender", selection: $genderCode) {
                    ForEach(UserProfile.GenderDisplay.allCodes, id: \.code) { item in
                        Text(item.label).tag(item.code)
                    }
                }
                Button("Save profile") {
                    Task {
                        await appModel.updateProfile(dateOfBirth: dateOfBirth, genderCode: genderCode)
                    }
                }
            }
            if let err = appModel.authError {
                Section {
                    Text(err).foregroundStyle(.red)
                }
            }
            Section {
                Button("Sign out", role: .destructive) {
                    appModel.signOut()
                }
            }
        }
        .navigationTitle("Profile")
        .onAppear {
            if let p = appModel.profile {
                dateOfBirth = p.dateOfBirth.dateValue()
                genderCode = p.genderCode
            }
        }
        .onChange(of: appModel.profile?.updatedAt) { _, _ in
            if let p = appModel.profile {
                dateOfBirth = p.dateOfBirth.dateValue()
                genderCode = p.genderCode
            }
        }
    }
}
