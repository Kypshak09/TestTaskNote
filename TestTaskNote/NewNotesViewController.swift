//
//  NewNotesViewController.swift
//  TestTaskNote
//
//  Created by Amir Zhunussov on 16.02.2023.
//

import UIKit
import SnapKit
import RealmSwift

class NewNotesViewController: UIViewController {
    
    
    var note: Note!
    weak var delegate: EditNoteDelegate?
    
    let realmManager = RealmManager.shared
    let realm = try! Realm()
    var array: Results<Note>!
    
    let textView: UITextView = {
        let text = UITextView()
        text.layer.cornerRadius = 15
        text.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0.482, blue: 0.329, alpha: 1)
        self.navigationController!.navigationBar.tintColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNotes))
        if let note = note {
            textView.text = note.text
            }
        configureConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           textView.becomeFirstResponder()
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    private func updateNote() {
        print("Updating note")
            
        note.updateDate = Date()
        delegate?.editNote()
        }
    
    @objc func saveNotes() {
        realmManager.saveData(text: textView.text)
    }
    
    func configureConstraint() {
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
}

extension NewNotesViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            print("Delete")
        } else {
            updateNote()
        }
    }
}

