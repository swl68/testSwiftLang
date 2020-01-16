//
//  MainViewController.swift
//  CodeRedStore
//
//  Created by denisok on 03/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter = MainViewPresenter()
    var myCollectionView = MainCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupCollectionView()
        setupConstraints()
    }
    
    func setupCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        view.addSubview(myCollectionView)
    }
    
    func setupConstraints() {
        myCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    deinit {
        print("deinit main")
    }
    
}

extension MainViewController: MainViewPresenterDelegate {
    func updateData() {
        DispatchQueue.main.async {
            print("reload collection")
            self.myCollectionView.reloadData()
        }
    }
    
    func showError(error: String) {
        showAlert("Error", error)
    }
    
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of row in sections")
        return presenter.getDataSourceCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.mainCell, for: indexPath) as? MainCollectionViewCell {
            
            let item = presenter.getItem(index: indexPath.row)
            cell.loadImage(imgStr: item.imgURL!)
            cell.configureCell(description: item.itemDescription!, brand: item.brand!, coast: item.coast!, imgUrl: item.imgURL!)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.getDataSourceCount() - 5 &&  presenter.getNextPage() > 1 {
            presenter.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailUrl = presenter.getItem(index: indexPath.row).detailURL else { return }
        let detailViewController = DetailViewController()
        let detailViewPresenter = DetailViewPresenter(view: detailViewController, detailUrlStr: detailUrl)
        detailViewController.presenter = detailViewPresenter
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
