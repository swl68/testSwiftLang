//
//  SizeTableViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 28/02/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class SizeTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let id = String(describing: SizeTableViewCell.self)
    
    private var layout = UICollectionViewFlowLayout()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView.backgroundColor = .white
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(SizeCollectionViewCell.self, forCellWithReuseIdentifier: SizeCollectionViewCell.id)
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        layout.itemSize = CGSize(width: 55, height: 55)
        collectionView.collectionViewLayout = layout
        
        collectionView.tag = row
        collectionView.reloadData()
    }
}
