//
//  AppConfiguration.swift
//  Symptra
//

import Foundation

enum AppConfiguration {
    static let imhRootURL = URL(string: "https://www.ptimhservice.com/api/v2/imh")!

    static var imhAPIUser: String {
        (Bundle.main.object(forInfoDictionaryKey: "IMH_API_USER") as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static var imhAPIPassword: String {
        (Bundle.main.object(forInfoDictionaryKey: "IMH_API_PASSWORD") as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Primetime `Namespace.Root` for IMH settings; optional until provided by IMH support.
    static var imhNamespaceRoot: String? {
        let raw = (Bundle.main.object(forInfoDictionaryKey: "IMH_NAMESPACE_ROOT") as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !raw.isEmpty, !raw.contains("$(") else { return nil }
        return raw
    }

    static var hasIMHCredentials: Bool {
        !imhAPIUser.isEmpty && !imhAPIPassword.isEmpty
    }
}
