//
//  MainTabView.swift
//  Symptra
//

import SwiftUI

struct MainTabView: View {
    @Bindable var appModel: AppViewModel

    var body: some View {
        TabView {
            HomeView(appModel: appModel)
                .tabItem { Label("Home", systemImage: "house.fill") }
            SessionsListView(appModel: appModel)
                .tabItem { Label("Sessions", systemImage: "doc.text.fill") }
            ProfileView(appModel: appModel)
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}
