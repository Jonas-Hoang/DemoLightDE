//
//  EntryModel.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//

import Foundation

struct EntryModel: Identifiable, Codable {
    let id: UUID
    var fullName: String
    var identityNumber: String
    var employeeID: String
    var signingDate: Date
    var note: String
    var department: String
    var date: Date

    init(id: UUID = UUID(), fullName: String, identityNumber: String, employeeID: String, signingDate: Date, note: String, department: String, date: Date = Date()) {
        self.id = id
        self.fullName = fullName
        self.identityNumber = identityNumber
        self.employeeID = employeeID
        self.signingDate = signingDate
        self.note = note
        self.department = department
        self.date = date
    }
}
