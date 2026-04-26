//
//  IMHJSONMutations.swift
//  Symptra
//

import Foundation

enum IMHJSONMutations {
    static func mergeSettingsQuestionForm(data: Data, namespaceRoot: String?) throws -> Data {
        var root = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        try IMHAPIClient.checkApiStatus(decodeApiStatus(from: root))

        var settings = root["Settings"] as? [String: Any] ?? [:]
        settings["QuestionForm"] = true
        if let namespaceRoot, !namespaceRoot.isEmpty {
            var ns = settings["Namespace"] as? [String: Any] ?? [:]
            ns["Root"] = namespaceRoot
            settings["Namespace"] = ns
        }
        root["Settings"] = settings
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func mergePatient(data: Data, dateOfBirth: Date, genderCode: String) throws -> Data {
        var root = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        try IMHAPIClient.checkApiStatus(decodeApiStatus(from: root))

        var patient = root["Patient"] as? [String: Any] ?? [:]
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "MM/dd/yyyy"
        patient["DateOfBirth"] = formatter.string(from: dateOfBirth)
        patient["Gender"] = genderCode
        root["Patient"] = patient
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func mergeProviderPlaceholder(data: Data) throws -> Data {
        var root = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        try IMHAPIClient.checkApiStatus(decodeApiStatus(from: root))

        var provider = root["Provider"] as? [String: Any] ?? [:]
        if provider.isEmpty {
            provider["FirstName"] = "Symptra"
            provider["LastName"] = "User"
        }
        root["Provider"] = provider
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func chiefComplaintBody(text: String) throws -> Data {
        let root: [String: Any] = [
            "ChiefComplaint": [
                "Text": text,
            ],
        ]
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func questionnaireQueueBody(names: [String]) throws -> Data {
        let items: [[String: Any]] = names.map { ["Name": $0] }
        let root: [String: Any] = [
            "QuestionnaireQueue": [
                "Questionnaires": items,
            ],
        ]
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func patientAnswerBody(answerMap: [String: Any]) throws -> Data {
        let root: [String: Any] = [
            "PatientAnswer": [
                "Answers": answerMap,
            ],
        ]
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    static func reportRequestBodyHTML() throws -> Data {
        let root: [String: Any] = [
            "Report": [
                "Format": "html",
            ],
        ]
        return try JSONSerialization.data(withJSONObject: root, options: [])
    }

    private static func decodeApiStatus(from root: [String: Any]) -> ApiStatusDTO? {
        guard let dict = root["ApiStatus"] as? [String: Any] else { return nil }
        guard let code = dict["ApiStatusCode"] as? Int else { return nil }
        let msg = dict["ApiMessage"] as? String
        let fw = dict["FWStatusCode"] as? Int
        let fwm = dict["FWMessage"] as? String
        return ApiStatusDTO(apiStatusCode: code, apiMessage: msg, fwStatusCode: fw, fwMessage: fwm)
    }
}
