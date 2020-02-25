//
//  MainCollectionViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 27/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell, CacheImageProtocol {
    
    static let mainCell = "mainCell"
    let cacheImage = CacheImage()
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cacheImage.delegateImage = self
        layer.cornerRadius = 10
        layer.shadowRadius = 2
        layer.shadowOffset = .init(width: 2, height: 2)
        backgroundColor = .lightGray
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
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2 - 60)
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
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
        startActivity()
    }
    
    func getImage(completeImage: UIImage) {
        myImageView.image = completeImage
        stopActivity()
    }
    
    func loadImage(imgStr: String) {
        startActivity()
        cacheImage.loadImageFromCache(imageStr: imgStr)
    }
    
    func startActivity() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
