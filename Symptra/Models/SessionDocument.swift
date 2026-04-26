//
//  SessionDocument.swift
//  Symptra
//

import Foundation
import FirebaseFirestore

struct SessionDocument: Codable, Sendable {
    var encounterId: String
    var apiLinks: [APILinkDTO]
    var apiLinksUpdatedAt: Timestamp
    var pipelineStage: String
    var chiefComplaintText: String?
    var status: String
    var interviewCursor: Int?
    var createdAt: Timestamp
    var updatedAt: Timestamp
    var completedAt: Timestamp?
    var reportHTMLDataBase64: String?
    var reportSummary: String?

    enum PipelineStage {
        static let encounterCreated = "encounterCreated"
        static let settingsConfigured = "settingsConfigured"
        static let patientConfigured = "patientConfigured"
        static let providerConfigured = "providerConfigured"
        static let chiefComplaintSet = "chiefComplaintSet"
        static let queueConfigured = "queueConfigured"
        static let interviewing = "interviewing"
        static let completed = "completed"
        static let reportFetched = "reportFetched"
    }

    enum Status {
        static let inProgress = "inProgress"
        static let completed = "completed"
        static let failed = "failed"
    }
}
