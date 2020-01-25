//
//  ThirdCell.swift
//  CodeRedStore
//
//  Created by denisok on 25/01/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    static let descriptionCell = "descriptionTableViewCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var brandLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coastLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 15)
        label.numberOfLines = 0
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        addSubview(nameLabel)
        addSubview(brandLabel)
        addSubview(coastLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        brandLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        brandLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        coastLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10).isActive = true
        coastLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        coastLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
       
        descriptionLabel.topAnchor.constraint(equalTo: coastLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    func configureCell(item: DescriptionModel) {
        descriptionLabel.text = item.description
        nameLabel.text = item.name
        brandLabel.text = item.brand
        coastLabel.text = item.coast
    }
    
}
