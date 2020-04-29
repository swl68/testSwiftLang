//
//  DetailPhotoTableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 11/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//


import UIKit

class DetailPhotoCollectionViewCell: UICollectionViewCell, CacheImageProtocol {
    static let id = String(describing: DetailPhotoCollectionViewCell.self)
    let cacheImage = CacheImage()
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.color = .black
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cacheImage.delegateImage = self
        backgroundColor = .white
        addSubview(myImageView)
        activityIndicator.center = center
        activityIndicator.style = .whiteLarge
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
