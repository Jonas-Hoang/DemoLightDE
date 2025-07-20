//
//  ContentView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var storage = EntryStorage()
    
    @State private var name = ""
    @State private var code = ""
    @State private var task = ""
    @State private var department = ""
    @State private var jobType = ""
    @State private var note = ""
    @State private var date = Date()
    
    var body: some View {
        TabView {
            VStack(alignment: .leading, spacing: 10) {
                Text("📝 Nhập công việc").font(.title2).bold()
                
                Form {
                    TextField("Họ tên", text: $name)
                    TextField("Mã nhân viên", text: $code)
                    TextField("Phòng ban", text: $department)
                    TextField("Loại công việc", text: $jobType)
                    DatePicker("Ngày làm việc", selection: $date, displayedComponents: .date)
                    TextField("Nội dung công việc", text: $task)
                    TextField("Ghi chú", text: $note)
                }

                Button("➕ Thêm") {
                    let newEntry = EntryModel(
                        name: name,
                        employeeCode: code,
                        taskContent: task,
                        department: department,
                        jobType: jobType,
                        note: note,
                        date: date
                    )
                    storage.add(newEntry)
                    name = ""; code = ""; task = ""; department = ""; jobType = ""; note = ""
                    date = Date()
                }
                .disabled(name.isEmpty || code.isEmpty || task.isEmpty)
                .buttonStyle(.borderedProminent)

                Divider()
                
                Text("📄 Danh sách:")
                List {
                    ForEach(storage.entries.reversed()) { entry in
                        VStack(alignment: .leading) {
                            Text("\(entry.name) - \(entry.employeeCode)").bold()
                            Text("📌 \(entry.taskContent)")
                            Text("🏢 \(entry.department) • 🗂️ \(entry.jobType)")
                            Text("🗓 \(entry.date.formatted(date: .numeric, time: .omitted))")
                            if !entry.note.isEmpty {
                                Text("📝 \(entry.note)").italic().foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: storage.delete)
                }
            }
            .tabItem {
                Label("Nhập liệu", systemImage: "square.and.pencil")
            }
            .padding()
            
            DashboardView(storage: storage)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
        }
        .frame(minWidth: 600, minHeight: 700)
    }
}

#Preview {
    ContentView()
}
