//
//  DetailPhotoTableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 11/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//


import UIKit

class DetailSizeCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: DetailSizeCollectionViewCell.self)
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myImageView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        myImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        myImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        myImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func loadImage(imgStr: String) {
        guard let url = URL(string: imgStr) else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            guard let loadData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                guard let loadImage = UIImage(data: loadData) else { return }
                self.myImageView.image = loadImage
            }
        }
    }
    
}
