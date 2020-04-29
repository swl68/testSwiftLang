//
//  FooterView.swift
//  CodeRedStore
//
//  Created by denisok on 15/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    var action: (()->() )?
    
    var basketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В корзину", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(addBasketButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.shadowOpacity = 0.5
        addSubview(basketButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        basketButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        basketButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        basketButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        basketButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    @objc func addBasketButton() {
        action?()
    }

    
}
