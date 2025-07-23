//
//  ParsedFields.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 23/7/25.
//

import Foundation

struct ParsedFields {
    var fullName: String = "Không rõ"
    var cccd: String = "Không rõ"
    var employeeID: String = "Không rõ"

    static func from(text: String) -> ParsedFields {
        var result = ParsedFields()

        if let name = text.range(of: #"Họ tên[:\-]?\s*([A-ZÀ-ỹ\s]+)"#, options: .regularExpression) {
            result.fullName = String(text[name]).components(separatedBy: ":").last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }

        if let cccdMatch = text.range(of: #"(\d{9,12})"#, options: .regularExpression) {
            result.cccd = String(text[cccdMatch])
        }

        if let idMatch = text.range(of: #"ID[:\-]?\s*(\w+)"#, options: .regularExpression) {
            result.employeeID = String(text[idMatch]).components(separatedBy: ":").last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }

        return result
    }
}
