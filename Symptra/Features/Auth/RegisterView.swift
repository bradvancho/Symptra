//
//  RegisterView.swift
//  Symptra
//

import SwiftUI

struct RegisterView: View {
    @Bindable var appModel: AppViewModel
    @Binding var showRegister: Bool

    @State private var email = ""
    @State private var password = ""
    @State private var dateOfBirth = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    @State private var genderCode = "M"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Create account")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity)

                TextField("Email", text: $email)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.vertical, 8)
                Divider()

                SecureField("Password (min 6 characters)", text: $password)
                    .textContentType(.newPassword)
                    .padding(.vertical, 8)
                Divider()

                DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)

                Picker("Gender", selection: $genderCode) {
                    ForEach(UserProfile.GenderDisplay.allCodes, id: \.code) { item in
                        Text(item.label).tag(item.code)
                    }
                }

                if let err = appModel.authError {
                    Text(err)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                Button {
                    Task {
                        await appModel.register(
                            email: email,
                            password: password,
                            dateOfBirth: dateOfBirth,
                            genderCode: genderCode
                        )
                    }
                } label: {
                    Text("Sign up")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.count < 6)

                Button("Back to login") {
                    showRegister = false
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
