//
//  QuestionFormContentView.swift
//  Symptra
//

import SwiftUI

struct QuestionFormContentView: View {
    let form: QuestionFormDTO
    @Bindable var interview: InterviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(form.text)
                .font(.title2.bold())

            if let msgs = form.validationMessages, !msgs.isEmpty {
                ForEach(Array(msgs.keys.sorted()), id: \.self) { key in
                    if let m = msgs[key] {
                        Text(m)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
            }

            ForEach(form.model.variables, id: \.variableName) { v in
                variableField(v)
            }
        }
    }

    @ViewBuilder
    private func variableField(_ v: QuestionVariableDTO) -> some View {
        let label = form.form.variableLayoutItems.first { $0.variableName == v.variableName }?.label ?? v.variableName
        let placeholder = form.form.variableLayoutItems.first { $0.variableName == v.variableName }?.placeholder ?? ""

        switch v.type.lowercased() {
        case "bool":
            Toggle(isOn: Binding(
                get: { (interview.answerStrings[v.variableName] ?? "false").lowercased() == "true" },
                set: { interview.setAnswerKey(v.variableName, $0 ? "true" : "false") }
            )) {
                Text(label)
            }
        case "integer":
            VStack(alignment: .leading, spacing: 4) {
                Text(label).font(.subheadline)
                TextField(placeholder.isEmpty ? "Number" : placeholder, text: Binding(
                    get: { interview.answerStrings[v.variableName] ?? "" },
                    set: { interview.setAnswerKey(v.variableName, $0) }
                ))
                .keyboardType(.numberPad)
            }
        default:
            if let enums = v.enumValues, !enums.isEmpty {
                let labels = form.form.variableLayoutItems.first { $0.variableName == v.variableName }?.labelMap
                VStack(alignment: .leading, spacing: 4) {
                    Text(label).font(.subheadline)
                    Picker(label, selection: Binding(
                        get: { interview.answerStrings[v.variableName] ?? enums.first ?? "" },
                        set: { interview.setAnswerKey(v.variableName, $0) }
                    )) {
                        ForEach(enums, id: \.self) { token in
                            Text(labels?[token] ?? token).tag(token)
                        }
                    }
                    .pickerStyle(.menu)
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label).font(.subheadline)
                    TextField(placeholder.isEmpty ? label : placeholder, text: Binding(
                        get: { interview.answerStrings[v.variableName] ?? "" },
                        set: { interview.setAnswerKey(v.variableName, $0) }
                    ))
                }
            }
        }
    }
}
