//
//  BasketTableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 16/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let id = String(describing: BasketTableViewCell.self)
    
    var bascketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        addSubview(bascketImageView)
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(coastLabel)
        addSubview(sizeLabel)
    }
    
    func configureCell(basket: Basket) {
        nameLabel.text = basket.name ?? "Неизвестно"
        coastLabel.text = basket.price ?? "0"
        sizeLabel.text = basket.size ?? "0"
        countLabel.text = "Кол-во: \(basket.count)"
    }
    
    func loadImage(_ image: UIImage) {
        print("loasd image")
        bascketImageView.image = image
    }
    
    func increatesCounter() {
        
    }
    
    func setupConstraints() {
        bascketImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        bascketImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        bascketImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bascketImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        countLabel.topAnchor.constraint(equalTo: bascketImageView.bottomAnchor, constant: 10).isActive = true
        countLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: bascketImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        coastLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        coastLabel.leftAnchor.constraint(equalTo: bascketImageView.rightAnchor, constant: 10).isActive = true
        //coastLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        sizeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        sizeLabel.leftAnchor.constraint(equalTo: coastLabel.rightAnchor, constant: 10).isActive = true
        sizeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

}
