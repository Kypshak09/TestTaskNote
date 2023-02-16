//
//  Model.swift
//  TestTaskNote
//
//  Created by Amir Zhunussov on 16.02.2023.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted var text: String = ""
        
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
        }
            
    var descriptionText: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(updateDate.format()) \(lines.first ?? "")"
        }
    @Persisted var updateDate: Date
    
    convenience init(text: String) {
        self.init()
        self.text = text
        }
    
}

extension Date {
    func format() -> String {
           let formatter = DateFormatter()
           if Calendar.current.isDateInToday(self) {
               formatter.dateFormat = "h:mm a"
               
           } else {
               formatter.dateFormat = "dd/MM/yy"
           }
           return formatter.string(from: self)
       }
}
