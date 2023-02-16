//
//  TableViewCell.swift
//  TestTaskNote
//
//  Created by Amir Zhunussov on 16.02.2023.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.482, blue: 0.329, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 30)
        return label
    }()
    
    let desription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        configureConstraint()
    }
    
    
    func configureConstraint() {
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-15)
            make.height.equalTo(73)
        }
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(25)
        }
        
        view.addSubview(desription)
        desription.snp.makeConstraints { make in
            make.top.equalTo(title.snp_bottomMargin).offset(7)
            make.leading.equalToSuperview().offset(10)
        }
    }

}
