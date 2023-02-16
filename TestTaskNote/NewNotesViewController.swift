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
    
    let viewToolBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    let toolBar: UIToolbar = {
    let toolbar = UIToolbar()
    toolbar.barTintColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
    toolbar.tintColor = UIColor(red: 1, green: 0.482, blue: 0.329, alpha: 1)
    return toolbar
    }()
    
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
        configureToolbar()
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
        
        view.addSubview(viewToolBar)
        viewToolBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
            make.height.equalTo(60)
        }
        
        viewToolBar.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    func configureToolbar() {
           let boldButton = UIBarButtonItem(title: "B", style: .plain, target: self, action: #selector(boldButtonPressed))
           let italicButton = UIBarButtonItem(title: "I", style: .plain, target: self, action: #selector(italicButtonPressed))
           let monoSpaceButton = UIBarButtonItem(title: "M", style: .plain, target: self, action: #selector(monoSpaceButtonPressed))
           let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           toolBar.setItems([boldButton, spacer, italicButton, spacer, monoSpaceButton], animated: false)
       }
    
    @objc func boldButtonPressed() {
        var attributes = textView.typingAttributes
            var isBold = false
            if let font = attributes[NSAttributedString.Key.font] as? UIFont {
                if let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold) {
                    isBold = true
                    let boldFont = UIFont(descriptor: fontDescriptor, size: font.pointSize)
                    attributes[NSAttributedString.Key.font] = boldFont
                }
            }
            if !isBold {
                let boldFont = UIFont.boldSystemFont(ofSize: 15)
                attributes[NSAttributedString.Key.font] = boldFont
            }
            textView.typingAttributes = attributes
    }
    
    @objc func italicButtonPressed() {
        
        var attributes = textView.typingAttributes
            var isItalic = false
            if let font = attributes[NSAttributedString.Key.font] as? UIFont {
                if let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
                    isItalic = true
                    let italicFont = UIFont(descriptor: fontDescriptor, size: font.pointSize)
                    attributes[NSAttributedString.Key.font] = italicFont
                }
            }
            if !isItalic {
                let italicFont = UIFont.boldSystemFont(ofSize: 15)
                attributes[NSAttributedString.Key.font] = italicFont
            }
            textView.typingAttributes = attributes
        
    }
    
    @objc func monoSpaceButtonPressed() {
        
        var attributes = textView.typingAttributes
            var isMono = false
            if let font = attributes[NSAttributedString.Key.font] as? UIFont {
                if let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitMonoSpace) {
                    isMono = true
                    let monoFont = UIFont(descriptor: fontDescriptor, size: font.pointSize)
                    attributes[NSAttributedString.Key.font] = monoFont
                }
            }
            if !isMono {
                let monoFont = UIFont.boldSystemFont(ofSize: 15)
                attributes[NSAttributedString.Key.font] = monoFont
            }
            textView.typingAttributes = attributes
        
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

