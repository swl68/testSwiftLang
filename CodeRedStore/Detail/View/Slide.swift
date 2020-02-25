//
//  Slide.swift
//  CodeRedStore
//
//  Created by denisok on 24/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

// возмонжо переделать ячейки под пэджконтрол
class Slide: UIView {

    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var myScrollView: UIScrollView = {
        let scrolView = UIScrollView()
        scrolView.backgroundColor = .yellow
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        return scrolView
    }()
    
    var myPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myScrollView)
        addSubview(myPageControl)
        addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    func setupConstraints() {
        myScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myScrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        myPageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        myPageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        myImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: myPageControl.bottomAnchor, constant: -5).isActive = true
    }
    
}
