//
//  EntryStorage.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 19/7/25.
//

import SwiftUI // 💡 RẤT QUAN TRỌNG
import Combine


class EntryStorage: ObservableObject {
    @Published var entries: [EntryModel] = []
    
    private let key = "entries"
    
    init() {
        load()
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        if let decoded = try? JSONDecoder().decode([EntryModel].self, from: data) {
            self.entries = decoded
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func add(_ entry: EntryModel) {
        entries.append(entry)
        save()
    }
    
    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        save()
    }
}
