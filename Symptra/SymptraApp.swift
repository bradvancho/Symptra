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
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
