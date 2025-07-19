//
//  ContentView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var storage = EntryStorage()
    
    @State private var name: String = ""
    @State private var employeeCode: String = ""
    @State private var taskContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📥 Nhập Dữ Liệu Nhân Viên")
                .font(.title)
                .bold()
            
            Group {
                TextField("Họ tên", text: $name)
                TextField("Mã nhân viên", text: $employeeCode)
                TextField("Nội dung công việc", text: $taskContent)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Thêm vào danh sách") {
                let newEntry = EntryModel(name: name, employeeCode: employeeCode, taskContent: taskContent)
                storage.add(newEntry)
                name = ""; employeeCode = ""; taskContent = ""
            }
            .disabled(name.isEmpty || employeeCode.isEmpty || taskContent.isEmpty)
            .buttonStyle(.borderedProminent)
            
            Divider().padding(.vertical)
            
            Text("📄 Danh sách đã nhập:")
                .font(.headline)
            
            List {
                ForEach(storage.entries) { entry in
                    VStack(alignment: .leading) {
                        Text("\(entry.name) • \(entry.employeeCode)")
                            .font(.subheadline).bold()
                        Text(entry.taskContent)
                            .font(.body)
                    }
                    .padding(4)
                }
                .onDelete(perform: storage.delete)
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 600)
    }
}

#Preview {
    ContentView()
}
