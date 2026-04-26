//
//  IdentifiedSession.swift
//  Symptra
//

import Foundation

struct IdentifiedSession: Identifiable, Sendable {
    let id: String
    var data: SessionDocument
}
