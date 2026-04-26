//
//  AuthContainerView.swift
//  Symptra
//

import SwiftUI

struct AuthContainerView: View {
    @Bindable var appModel: AppViewModel
    @State private var showRegister = false

    var body: some View {
        NavigationStack {
            if showRegister {
                RegisterView(appModel: appModel, showRegister: $showRegister)
            } else {
                LoginView(appModel: appModel, showRegister: $showRegister)
            }
        }
    }
}
