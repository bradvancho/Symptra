//
//  CompleteProfileGateView.swift
//  Symptra
//

import SwiftUI

/// Shown if legacy account is missing profile fields.
struct CompleteProfileGateView: View {
    @Bindable var appModel: AppViewModel

    @State private var dateOfBirth = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    @State private var genderCode = "M"

    var body: some View {
        NavigationStack {
            Form {
                Section("Complete your profile") {
                    DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                    Picker("Gender", selection: $genderCode) {
                        ForEach(UserProfile.GenderDisplay.allCodes, id: \.code) { item in
                            Text(item.label).tag(item.code)
                        }
                    }
                }
                if let err = appModel.authError {
                    Section {
                        Text(err).foregroundStyle(.red)
                    }
                }
                Section {
                    Button("Save and continue") {
                        Task {
                            await appModel.updateProfile(dateOfBirth: dateOfBirth, genderCode: genderCode)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
