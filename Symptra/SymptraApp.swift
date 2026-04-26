//
//  SymptraApp.swift
//  Symptra
//
//  Created by Brad vancho on 4/26/26.
//

import SwiftUI
import FirebaseCore

@main
struct SymptraApp: App {
    @State private var appModel = AppViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView(appModel: appModel)
        }
    }
}
