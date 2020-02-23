//
//  TableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 28/01/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let id = String(describing: TableViewCell.self)
    
    var clothesNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        addSubview(clothesNameLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(text: String) {
        clothesNameLabel.text = text
    }
    
    func setupConstraints() {
        clothesNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        clothesNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        clothesNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        clothesNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
}
