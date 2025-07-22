//
//  ContractView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 22/7/25.
//

import SwiftUI

struct ContractView: View {
    @ObservedObject var storage: EntryStorage

    var latestEntry: EntryModel? {
        storage.entries.last
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("📄 MẪU HỢP ĐỒNG LAO ĐỘNG").font(.title).bold()

                if let entry = latestEntry {
                    Group {
                        Text("Họ tên: \(entry.fullName)")
                        Text("Số CCCD: \(entry.identityNumber)")
                        Text("Mã nhân viên: \(entry.employeeID)")
                        Text("Ngày ký hợp đồng: \(entry.signingDate.formatted(date: .long, time: .omitted))")
                        if !entry.note.isEmpty {
                            Text("Ghi chú: \(entry.note)")
                        }
                    }
                    .font(.body)
                    .padding(.bottom, 10)

                    Text("Nội dung hợp đồng:")
                    Text("""
                    Căn cứ vào Bộ luật Lao động, hai bên thỏa thuận ký kết hợp đồng với nội dung như sau:

                    - Bên A (Công ty) đồng ý tuyển dụng \(entry.fullName), CCCD: \(entry.identityNumber).
                    - Vị trí: Nhân viên (Mã số: \(entry.employeeID)).
                    - Ngày bắt đầu làm việc: \(entry.signingDate.formatted(date: .long, time: .omitted)).

                    Hai bên cam kết thực hiện nghiêm túc các điều khoản trong hợp đồng này.
                    """)
                    .multilineTextAlignment(.leading)
                } else {
                    Text("⚠️ Chưa có dữ liệu nhập. Vui lòng nhập thông tin ở tab “Nhập liệu”.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding()
        }
    }
}
