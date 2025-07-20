//
//  DashboardView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 20/7/25.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var storage: EntryStorage
    
    var totalTasks: Int {
        storage.entries.count
    }
    
    var tasksByDepartment: [String: Int] {
        Dictionary(grouping: storage.entries, by: { $0.department })
            .mapValues { $0.count }
    }
    
    var tasksByDate: [String: Int] {
        Dictionary(grouping: storage.entries, by: {
            DateFormatter.localizedString(from: $0.date, dateStyle: .short, timeStyle: .none)
        })
        .mapValues { $0.count }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("📊 Thống kê công việc").font(.title2).bold()
            Text("Tổng số công việc: \(totalTasks)").font(.headline)
            
            Divider()
            Text("📁 Theo phòng ban:")
            ForEach(tasksByDepartment.sorted(by: { $0.key < $1.key }), id: \.key) { dept, count in
                Text("- \(dept): \(count)")
            }
            
            Divider()
            Text("🗓 Theo ngày:")
            ForEach(tasksByDate.sorted(by: { $0.key < $1.key }), id: \.key) { date, count in
                Text("- \(date): \(count)")
            }
        }
        .padding()
    }
}
