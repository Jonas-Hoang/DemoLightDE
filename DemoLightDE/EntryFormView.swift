//
//  EntryFormView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 22/7/25.
//

import SwiftUI

struct EntryFormView: View {
    @ObservedObject var storage: EntryStorage

    @State private var fullName = ""
    @State private var identityNumber = ""
    @State private var employeeID = ""
    @State private var signingDate = Date()
    @State private var note = ""
    @State private var department = ""
    @State private var entryDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("✍️ Nhập thông tin hợp đồng").font(.title2).bold()

            Form {
                TextField("Họ tên", text: $fullName)
                TextField("Số CCCD", text: $identityNumber)
                TextField("ID Nhân viên", text: $employeeID)
                TextField("Phòng ban", text: $department)
                DatePicker("Ngày ký", selection: $signingDate, displayedComponents: .date)
                DatePicker("Ngày nhập dữ liệu", selection: $entryDate, displayedComponents: .date)
                TextField("Ghi chú", text: $note)
            }

            Button("➕ Thêm") {
                let newEntry = EntryModel(
                    fullName: fullName,
                    identityNumber: identityNumber,
                    employeeID: employeeID,
                    signingDate: signingDate,
                    note: note,
                    department: department,
                    date: entryDate
                )
                storage.add(newEntry)
                fullName = ""
                identityNumber = ""
                employeeID = ""
                department = ""
                note = ""
                signingDate = Date()
                entryDate = Date()
            }
            .disabled(fullName.isEmpty || identityNumber.isEmpty || employeeID.isEmpty || department.isEmpty)
            .buttonStyle(.borderedProminent)

            Divider()

            Text("📋 Danh sách đã nhập:")
            List {
                ForEach(storage.entries.reversed()) { entry in
                    VStack(alignment: .leading) {
                        Text("\(entry.fullName) • \(entry.employeeID)").bold()
                        Text("📅 Ngày ký: \(entry.signingDate.formatted(date: .numeric, time: .omitted))")
                        Text("📂 Phòng ban: \(entry.department)")
                        Text("🗓️ Ngày nhập: \(entry.date.formatted(date: .numeric, time: .omitted))")
                        Text("🪪 CCCD: \(entry.identityNumber)")
                        if !entry.note.isEmpty {
                            Text("📝 \(entry.note)").italic().foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: storage.delete)
            }
        }
        .padding()
    }
}
