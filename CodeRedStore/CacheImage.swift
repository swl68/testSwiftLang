//
//  CacheImage.swift
//  CodeRedStore
//
//  Created by denisok on 25/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

fileprivate let cacheImage = NSCache<NSString, UIImage>()

protocol CacheImageProtocol: class {
    func getImage(completeImage: UIImage)
}

class CacheImage {
    private var imgStr: String?
    var delegateImage: CacheImageProtocol?
    
    private func loadImageFromUrl(imageStr: String) {
        self.imgStr = imageStr
        guard let url = URL(string: imageStr) else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            guard let loadData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                guard let loadImage = UIImage(data: loadData) else { return }
                
                if self.imgStr == imageStr {
                    self.delegateImage?.getImage(completeImage: loadImage)
                }
                cacheImage.setObject(loadImage, forKey: url.absoluteString as NSString)
            }
        }
    }
    
    func loadImageFromCache(imageStr: String) {
        self.imgStr = imageStr
        guard let url = URL(string: imageStr) else { return }
        
        if let cacheImage = cacheImage.object(forKey: url.absoluteString as NSString), self.imgStr == imageStr {
            self.delegateImage?.getImage(completeImage: cacheImage)
        } else {
            loadImageFromUrl(imageStr: imageStr)
        }
    }
}
