//
//  SessionFirestoreService.swift
//  Symptra
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import OSLog

@MainActor
final class SessionFirestoreService {
    private let db = Firestore.firestore()

    private func collection(uid: String) -> CollectionReference {
        db.collection("users").document(uid).collection("sessions")
    }

    func listenSessions(uid: String, onUpdate: @escaping @Sendable ([IdentifiedSession]) -> Void) -> ListenerRegistration {
        collection(uid: uid)
            .order(by: "updatedAt", descending: true)
            .addSnapshotListener { snapshot, error in
                Task { @MainActor in
                    if let error {
                        Logger.firestore.error("sessions listen failed: \(error.localizedDescription, privacy: .public)")
                        return
                    }
                    guard let docs = snapshot?.documents else {
                        onUpdate([])
                        return
                    }
                    let items: [IdentifiedSession] = docs.compactMap { doc in
                        guard let data = try? doc.data(as: SessionDocument.self) else { return nil }
                        return IdentifiedSession(id: doc.documentID, data: data)
                    }
                    onUpdate(items)
                }
            }
    }

    func saveSession(uid: String, id: String?, document: SessionDocument) async throws -> String {
        let col = collection(uid: uid)
        let ref: DocumentReference
        if let id, !id.isEmpty {
            ref = col.document(id)
        } else {
            ref = col.document()
        }
        try ref.setData(from: document, merge: true)
        return ref.documentID
    }

    func deleteSession(uid: String, id: String) async throws {
        try await collection(uid: uid).document(id).delete()
    }
}
