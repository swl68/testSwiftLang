//
//  MainCollectionView.swift
//  CodeRedStore
//
//  Created by denisok on 02/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    var myCollectionLayout = UICollectionViewLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: .init())
        self.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.mainCell)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout = getLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLayout() -> UICollectionViewFlowLayout {
         let layout = UICollectionViewFlowLayout()
         layout.itemSize = getCellSize()
         layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
         return layout
     }
     
     func getCellSize() -> CGSize {
         let width: CGFloat = UIScreen.main.bounds.size.width / 2 - 20
         let height: CGFloat = 320.0
         let cellSize = CGSize(width: width, height: height)
         return cellSize
     }
    
    func setupConstraints() {
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
