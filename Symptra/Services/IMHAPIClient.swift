//
//  IMHAPIClient.swift
//  Symptra
//

import Foundation
import OSLog

enum IMHAPIError: LocalizedError {
    case invalidURL
    case notConfigured
    case httpStatus(Int)
    case decoding(Error)
    case apiRejected(code: Int, message: String?)
    case emptyBody

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid IMH URL."
        case .notConfigured: return "IMH API credentials are missing. Add Config/Secrets.xcconfig."
        case .httpStatus(let c): return "Server returned status \(c)."
        case .decoding: return "Could not read the server response."
        case .apiRejected(_, let message): return message ?? "The interview service rejected the request."
        case .emptyBody: return "Empty response from the interview service."
        }
    }
}

final class IMHAPIClient: @unchecked Sendable {
    private let authHeader: String
    private let session: URLSession

    init(user: String, password: String) {
        let raw = "\(user):\(password)"
        authHeader = "Basic \(Data(raw.utf8).base64EncodedString())"
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = 120
        config.timeoutIntervalForResource = 300
        session = URLSession(configuration: config)
    }

    convenience init?() {
        guard AppConfiguration.hasIMHCredentials else { return nil }
        self.init(user: AppConfiguration.imhAPIUser, password: AppConfiguration.imhAPIPassword)
    }

    func data(method: String, url: URL, body: Data? = nil) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        #if DEBUG
        Logger.imh.debug("IMH \(method, privacy: .public) \(url.absoluteString, privacy: .public)")
        #endif
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw IMHAPIError.httpStatus(-1)
        }
        guard (200 ... 299).contains(http.statusCode) else {
            #if DEBUG
            Logger.imh.error("IMH HTTP \(http.statusCode, privacy: .public)")
            #endif
            throw IMHAPIError.httpStatus(http.statusCode)
        }
        return data
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw IMHAPIError.decoding(error)
        }
    }

    static func checkApiStatus(_ status: ApiStatusDTO?) throws {
        guard let status else { return }
        guard status.isOK else {
            throw IMHAPIError.apiRejected(code: status.apiStatusCode, message: status.apiMessage)
        }
    }
}

extension Array where Element == APILinkDTO {
    func link(resource: String) -> APILinkDTO? {
        first { $0.resourceName.lowercased() == resource.lowercased() }
    }
}
