//
//  UserProfile.swift
//  Symptra
//

import Foundation
import FirebaseFirestore

struct UserProfile: Codable, Sendable {
    var email: String?
    var dateOfBirth: Timestamp
    var genderCode: String
    var profileCompleted: Bool
    var createdAt: Timestamp
    var updatedAt: Timestamp

    enum GenderDisplay {
        static func label(for code: String) -> String {
            switch code {
            case "M": return "Male"
            case "F": return "Female"
            default: return "Other"
            }
        }

        static let allCodes: [(code: String, label: String)] = [
            ("M", "Male"), ("F", "Female"), ("U", "Other"),
        ]
    }
}
