//
//  UserProfileService.swift
//  Symptra
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import OSLog

enum UserProfileServiceError: LocalizedError {
    case notSignedIn

    var errorDescription: String? {
        switch self {
        case .notSignedIn: return "You must be signed in."
        }
    }
}

@MainActor
final class UserProfileService {
    private let db = Firestore.firestore()

    private func userDoc(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }

    func loadProfile(uid: String) async throws -> UserProfile? {
        let snap = try await userDoc(uid: uid).getDocument()
        return try snap.data(as: UserProfile.self)
    }

    func saveProfile(uid: String, email: String?, dateOfBirth: Date, genderCode: String) async throws {
        let now = Timestamp(date: Date())
        let dob = Timestamp(date: dateOfBirth)
        let profile = UserProfile(
            email: email,
            dateOfBirth: dob,
            genderCode: genderCode,
            profileCompleted: true,
            createdAt: now,
            updatedAt: now
        )
        let ref = userDoc(uid: uid)
        try ref.setData(from: profile, merge: true)
        Logger.firestore.debug("Profile saved for user document")
    }
}
