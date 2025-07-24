//
//  ContentView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var storage = EntryStorage()

    var body: some View {
        TabView {
            ContractView(storage: storage)
                .tabItem {
                    Label("📄 Hợp đồng", systemImage: "doc.text")
                }

            EntryFormView(storage: storage)
                .tabItem {
                    Label("✍️ Nhập liệu", systemImage: "square.and.pencil")
                }

            OCRImportView(storage: storage)
                .tabItem {
                    Label("🧠 OCR", systemImage: "text.viewfinder")
                }
        }
        .frame(minWidth: 600, minHeight: 600)
    }
}


#Preview {
    ContentView()
}
