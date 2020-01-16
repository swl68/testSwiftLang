//
//  DetailCollectionViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 13/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class AnotherColorTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    static let detailCell = "anotherColorTableViewCell"
    private var layout = UICollectionViewFlowLayout()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = layout
        
        collectionView.register(DetailSizeCollectionViewCell.self, forCellWithReuseIdentifier: DetailSizeCollectionViewCell.galeriCell)
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        layout.itemSize = CGSize(width: 56, height: 56)
        collectionView.collectionViewLayout = layout
        
        collectionView.tag = row
        collectionView.reloadData()
    }
}
