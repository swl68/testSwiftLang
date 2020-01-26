//
//  DetailCollectionViewCell.swift
//  CodeRedStore
//
//  Created by denisok on 13/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let id = String(describing: DetailTableViewCell.self)
    
    private var layout = UICollectionViewFlowLayout()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView.backgroundColor = .lightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        
        collectionView.register(DetailPhotoCollectionViewCell.self, forCellWithReuseIdentifier: DetailPhotoCollectionViewCell.id)
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
        
        layout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
        collectionView.collectionViewLayout = layout
        collectionView.tag = row
        collectionView.reloadData()
    }
}
