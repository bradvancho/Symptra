//
//  AppViewModel.swift
//  Symptra
//

import Observation
import FirebaseAuth
import OSLog

@MainActor
@Observable
final class AppViewModel {
    private let auth = Auth.auth()
    private let profileService = UserProfileService()

    private(set) var firebaseUser: User?
    private(set) var profile: UserProfile?
    private(set) var isLoadingProfile = false
    var authError: String?

    nonisolated(unsafe) private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = auth.addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                await self?.apply(user: user)
            }
        }
    }

    deinit {
        if let handle {
            auth.removeStateDidChangeListener(handle)
        }
    }

    private func apply(user: User?) async {
        firebaseUser = user
        authError = nil
        guard let user else {
            profile = nil
            return
        }
        isLoadingProfile = true
        defer { isLoadingProfile = false }
        do {
            profile = try await profileService.loadProfile(uid: user.uid)
        } catch {
            Logger.auth.error("load profile failed: \(error.localizedDescription, privacy: .public)")
            profile = nil
        }
    }

    func signIn(email: String, password: String) async {
        authError = nil
        do {
            _ = try await auth.signIn(withEmail: email, password: password)
        } catch {
            authError = error.localizedDescription
            Logger.auth.error("sign in failed")
        }
    }

    func register(email: String, password: String, dateOfBirth: Date, genderCode: String) async {
        authError = nil
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            try await profileService.saveProfile(
                uid: result.user.uid,
                email: email,
                dateOfBirth: dateOfBirth,
                genderCode: genderCode
            )
            await apply(user: result.user)
        } catch {
            authError = error.localizedDescription
            Logger.auth.error("register failed")
        }
    }

    func updateProfile(dateOfBirth: Date, genderCode: String) async {
        guard let user = firebaseUser else { return }
        authError = nil
        do {
            try await profileService.saveProfile(
                uid: user.uid,
                email: user.email,
                dateOfBirth: dateOfBirth,
                genderCode: genderCode
            )
            profile = try await profileService.loadProfile(uid: user.uid)
        } catch {
            authError = error.localizedDescription
        }
    }

    func signOut() {
        do {
            try auth.signOut()
        } catch {
            authError = error.localizedDescription
        }
    }

    func refreshProfile() async {
        await apply(user: firebaseUser)
    }
}
