//
//  RealmManager.swift
//  TestTaskNote
//
//  Created by Amir Zhunussov on 16.02.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init () {}
    let realm = try! Realm()
    
    func saveData(text: String) {
        let note = Note(text: text)
        try! realm.write {
            realm.add(note)
        }
    }
    
    func getData() -> Results<Note> {
        let data = realm.objects(Note.self)
        return data
    }
    
    func deleteData(data: Note) {
        try! realm.write {
            realm.delete(data)
        }
    }
}
