//
//  QuestionFormDTO.swift
//  Symptra
//

import Foundation

struct QuestionResponseDTO: Codable, Sendable {
    var apiStatus: ApiStatusDTO?
    var questionId: String?
    var question: QuestionWrapperDTO?

    enum CodingKeys: String, CodingKey {
        case apiStatus = "ApiStatus"
        case questionId = "QuestionId"
        case question = "Question"
    }
}

struct QuestionWrapperDTO: Codable, Sendable {
    var questionForm: QuestionFormDTO?

    enum CodingKeys: String, CodingKey {
        case questionForm = "QuestionForm"
    }
}

struct QuestionFormDTO: Codable, Sendable {
    var text: String
    var model: QuestionFormModelDTO
    var form: QuestionFormLayoutDTO
    var validationMessages: [String: String]?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case model = "Model"
        case form = "Form"
        case validationMessages = "ValidationMessages"
    }
}

struct QuestionFormModelDTO: Codable, Sendable {
    var variables: [QuestionVariableDTO]

    enum CodingKeys: String, CodingKey {
        case variables = "Variables"
    }
}

struct QuestionVariableDTO: Codable, Sendable {
    var variableName: String
    var type: String
    var enumValues: [String]?
    var required: Bool?
    var minimum: Int?
    var maximum: Int?
    var maxLength: Int?

    enum CodingKeys: String, CodingKey {
        case variableName = "VariableName"
        case type = "Type"
        case enumValues = "Enum"
        case required = "Required"
        case minimum = "Minimum"
        case maximum = "Maximum"
        case maxLength = "MaxLength"
    }
}

struct QuestionFormLayoutDTO: Codable, Sendable {
    var formLayoutItems: [FormLayoutItemDTO]
    var variableLayoutItems: [VariableLayoutItemDTO]

    enum CodingKeys: String, CodingKey {
        case formLayoutItems = "FormLayoutItems"
        case variableLayoutItems = "VariableLayoutItems"
    }
}

struct FormLayoutItemDTO: Codable, Sendable {
    var type: String
    var variableName: String?
    var variableNames: [String]?
    var groupDisplayName: String?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case variableName = "VariableName"
        case variableNames = "VariableNames"
        case groupDisplayName = "GroupDisplayName"
    }
}

struct VariableLayoutItemDTO: Codable, Sendable {
    var variableName: String
    var label: String?
    var labelMap: [String: String]?
    var placeholder: String?

    enum CodingKeys: String, CodingKey {
        case variableName = "VariableName"
        case label = "Label"
        case labelMap = "LabelMap"
        case placeholder = "Placeholder"
    }
}
