//
//  RootView.swift
//  Symptra
//

import SwiftUI

struct RootView: View {
    @Bindable var appModel: AppViewModel

    var body: some View {
        Group {
            if appModel.firebaseUser == nil {
                AuthContainerView(appModel: appModel)
            } else if appModel.isLoadingProfile {
                ProgressView("Loading…")
            } else if appModel.profile?.profileCompleted != true {
                CompleteProfileGateView(appModel: appModel)
            } else {
                MainTabView(appModel: appModel)
            }
        }
    }
}
