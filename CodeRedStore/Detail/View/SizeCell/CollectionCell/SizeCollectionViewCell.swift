//
//  FourthCell.swift
//  CodeRedStore
//
//  Created by denisok on 28/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: SizeCollectionViewCell.self)
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet {
            onSelected()
        }
    }
    
    private var sizeModel: SizeModel? {
        didSet {
            self.isSelected = sizeModel?.isSelectedCell ?? false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sizeLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(size: String) {
        if size.count > 2 {
            sizeLabel.font = UIFont(name: "Arial", size: 14)
        }
        sizeLabel.text = size
    }
    
    private func onSelected() {
        
        switch isSelected {
        case true:
            let myColor = UIColor.red
            layer.borderWidth = 3
            layer.borderColor = myColor.cgColor
        default:
            let myColor = UIColor.white
            layer.borderWidth = 0
            layer.borderColor = myColor.cgColor
        }
    }
    
    private func setupConstraints() {
        sizeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        sizeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        sizeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        sizeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
    }
}
