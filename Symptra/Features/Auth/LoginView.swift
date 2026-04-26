//
//  LoginView.swift
//  Symptra
//

import SwiftUI

struct LoginView: View {
    @Bindable var appModel: AppViewModel
    @Binding var showRegister: Bool

    @State private var email = ""
    @State private var password = ""
    @FocusState private var focused: Field?

    private enum Field {
        case email, password
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Login")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("you@example.com", text: $email)
                        .textContentType(.username)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focused, equals: .email)
                    Divider()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .focused($focused, equals: .password)
                    Divider()
                }

                if let err = appModel.authError {
                    Text(err)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                Button {
                    Task {
                        await appModel.signIn(email: email, password: password)
                    }
                } label: {
                    Text("LOGIN")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .disabled(email.isEmpty || password.isEmpty)

                Button("Create account") {
                    showRegister = true
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
