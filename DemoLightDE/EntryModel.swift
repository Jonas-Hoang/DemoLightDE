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
    
    init(id: UUID = UUID(), name: String, employeeCode: String, taskContent: String) {
        self.id = id
        self.name = name
        self.employeeCode = employeeCode
        self.taskContent = taskContent
    }
}
