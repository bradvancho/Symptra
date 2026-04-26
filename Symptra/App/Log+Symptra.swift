//
//  Log+Symptra.swift
//  Symptra
//

import OSLog

extension Logger {
    static let app = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Symptra", category: "app")
    static let auth = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Symptra", category: "auth")
    static let firestore = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Symptra", category: "firestore")
    static let imh = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Symptra", category: "imh")
}
