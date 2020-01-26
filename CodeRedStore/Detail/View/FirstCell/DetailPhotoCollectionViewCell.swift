//
//  DetailPhotoTableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 11/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//


import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

class DetailPhotoCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: DetailPhotoCollectionViewCell.self)
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(myImageView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        myImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        myImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        myImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }
    
    func loadImage(imgStr: String) {
        guard let url = URL(string: imgStr) else { return }
        
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.myImageView.image = cacheImage
        } else {
        
            DispatchQueue.global(qos: .background).async {
                
                guard let loadData = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    guard let loadImage = UIImage(data: loadData) else { return }
                        self.myImageView.image = loadImage
                    imageCache.setObject(loadImage, forKey: url.absoluteString as NSString)
                }
            }
        }
    }
    
}
