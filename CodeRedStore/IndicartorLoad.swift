//
//  IndicartorLoad.swift
//  CodeRedStore
//
//  Created by denisok on 20/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

// Позже завязать на протокол
protocol IndicatorLoadProtocol: class {
    func showIndicator(view: UIView, indicator: UIActivityIndicatorView)
    func hideIndicator(view: UIView, indicator: UIActivityIndicatorView)
}

class IndicatorLoad: UIView, IndicatorLoadProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showIndicator(view: UIView, indicator: UIActivityIndicatorView) {
        self.frame = view.frame
        self.center = view.center
        self.backgroundColor = .white
        
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = .lightGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        indicator.center = view.center
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.style = .whiteLarge
        indicator.center = CGPoint(x: loadingView.frame.width / 2, y: loadingView.frame.height / 2)
        self.addSubview(loadingView)
        loadingView.addSubview(indicator)
        view.addSubview(self)
        indicator.startAnimating()
    }
    
    func hideIndicator(view: UIView, indicator: UIActivityIndicatorView) {
        self.removeFromSuperview()
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    deinit {
        print("deinit indicator")
    }
}

       
      
      
      
     
