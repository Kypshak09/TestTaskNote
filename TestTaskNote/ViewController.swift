//
//  ViewController.swift
//  TestTaskNote
//
//  Created by Amir Zhunussov on 16.02.2023.
//

import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController, EditNoteDelegate  {
    func editNote() {
        array = array.sorted(byKeyPath: "updateDate", ascending: false)
        tableView.reloadData()
    }
    
    let identifier = "CellIdentifier"
    
    var array: Results<Note>!
    let realmManager = RealmManager.shared
    let realm = try! Realm()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont(name: "Verdana", size: 40)
        return label
    }()
    
    let labelAmount: UILabel = {
        let label = UILabel()
        label.text = "1 notes"
        label.font = UIFont.italicSystemFont(ofSize: 20)
        return label
    }()
    
    let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.863, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(goToNextScreen))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red:  0.992, green: 0.655, blue: 0.412, alpha: 1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        array = realm.objects(Note.self)
        configureConstraints()
        editNote()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        labelAmount.text = "\(array.count) amount of Notes"
        tableView.reloadData()
    }
    
    @objc func goToNextScreen() {
        navigationController?.pushViewController(NewNotesViewController(), animated: true)
    }
    
    func configureConstraints() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(labelAmount)
        labelAmount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp_bottomMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(labelAmount).offset(-40)
        }
    }

    private func goToEditNote(_ note: Note) {
           let controller = NewNotesViewController()
           controller.note = note
           controller.delegate = self
           navigationController?.pushViewController(controller, animated: true)
       }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TableViewCell
        cell.desription.text = array[indexPath.row].descriptionText
        cell.title.text = array[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(array[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = array[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteData(data: row)
            tableView.reloadData()
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    

    
}

