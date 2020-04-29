//
//  IndicartorLoad.swift
//  CodeRedStore
//
//  Created by denisok on 20/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class IndicatorLoad: UIView {
    
    var myActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showIndicator(view: UIView) {
        self.frame = view.frame
        self.center = view.center
        self.backgroundColor = .white
        
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - 40.0)
        loadingView.backgroundColor = .lightGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        //
        myActivityIndicator.center = view.center
        myActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        myActivityIndicator.style = .whiteLarge
        myActivityIndicator.center = CGPoint(x: loadingView.frame.width / 2, y: loadingView.frame.height / 2)
        self.addSubview(loadingView)
        loadingView.addSubview(myActivityIndicator)
        view.addSubview(self)
        myActivityIndicator.startAnimating()
    }
    
    func hideIndicator(view: UIView) {
        self.removeFromSuperview()
        myActivityIndicator.stopAnimating()
        myActivityIndicator.removeFromSuperview()
    }
    
    deinit {
        print("deinit indicator")
    }
}

       
      
      
      
     
