//
//  EntryModel.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//

import Foundation

struct EntryModel: Identifiable, Codable {
    let id: UUID
    var name: String
    var employeeCode: String
    var taskContent: String
    var department: String
    var jobType: String
    var note: String
    var date: Date
    
    init(id: UUID = UUID(),
         name: String,
         employeeCode: String,
         taskContent: String,
         department: String,
         jobType: String,
         note: String,
         date: Date) {
        self.id = id
        self.name = name
        self.employeeCode = employeeCode
        self.taskContent = taskContent
        self.department = department
        self.jobType = jobType
        self.note = note
        self.date = date
    }
}
