//
//  APILinkDTO.swift
//  Symptra
//

import Foundation

struct APILinkDTO: Codable, Sendable, Hashable, Identifiable {
    var title: String?
    var description: String?
    var resourceName: String
    var httpMethods: [String]
    var url: String

    var id: String { resourceName + url }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case description = "Description"
        case resourceName = "ResourceName"
        case httpMethods = "HttpMethods"
        case url = "URL"
    }

    func resolvedURL(encounterId: String) -> String {
        url.replacingOccurrences(of: "/encounters//", with: "/encounters/\(encounterId)/")
    }
}

struct ApiStatusDTO: Codable, Sendable {
    var apiStatusCode: Int
    var apiMessage: String?
    var fwStatusCode: Int?
    var fwMessage: String?

    enum CodingKeys: String, CodingKey {
        case apiStatusCode = "ApiStatusCode"
        case apiMessage = "ApiMessage"
        case fwStatusCode = "FWStatusCode"
        case fwMessage = "FWMessage"
    }

    var isOK: Bool { apiStatusCode == 5000 }
}

struct EncounterBodyDTO: Codable, Sendable {
    var encounterId: String
    var apiLinks: [APILinkDTO]

    enum CodingKeys: String, CodingKey {
        case encounterId = "EncounterId"
        case apiLinks = "ApiLinks"
    }
}

struct EncounterCreateResponse: Codable, Sendable {
    var apiStatus: ApiStatusDTO?
    var encounter: EncounterBodyDTO?

    enum CodingKeys: String, CodingKey {
        case apiStatus = "ApiStatus"
        case encounter = "Encounter"
    }
}

struct IMHRootLinksResponse: Codable, Sendable {
    var apiLinks: [APILinkDTO]?

    enum CodingKeys: String, CodingKey {
        case apiLinks = "ApiLinks"
    }
}
