//
//  MainCollectionViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 27/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

class MainCollectionViewCell: UICollectionViewCell {
    
    static let mainCell = "mainCell"
    var imageUrlString: String?
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        addSubview(myImageView)
        addSubview(descriptionLabel)
        addSubview(brandLabel)
        addSubview(coastLabel)
    }
    
    func setupConstraints() {
        myImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        brandLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 5).isActive = true
        brandLabel.leftAnchor.constraint(equalTo: myImageView.leftAnchor).isActive = true
        brandLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: myImageView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: myImageView.rightAnchor).isActive = true
        
        coastLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        coastLabel.leftAnchor.constraint(equalTo: myImageView.leftAnchor).isActive = true
        coastLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func configureCell(description: String, brand: String, coast: String, imgUrl: String) {
        descriptionLabel.text = description
        brandLabel.text = brand
        coastLabel.text = coast
        imageUrlString = imgUrl
    }

    func loadImage(imgStr: String) {
        
        imageUrlString = imgStr
        guard let url = URL(string: imgStr) else { return }
        
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.myImageView.image = cacheImage
        } else {
            myImageView.image = nil
            DispatchQueue.global(qos: .background).async {
                
                guard let loadData = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    guard let loadImage = UIImage(data: loadData) else { return }
                    
                    if self.imageUrlString == imgStr {
                        self.myImageView.image = loadImage
                    }
                    imageCache.setObject(loadImage, forKey: url.absoluteString as NSString)
                }
            }
        }
    }
    
}
