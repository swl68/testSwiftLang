//
//  MainViewController.swift
//  CodeRedStore
//
//  Created by denisok on 03/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPreseneterProtocol?
    var myCollectionView = MainCollectionView()
    var indicatorLoad: IndicatorLoad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorLoad = IndicatorLoad()
        setupCollectionView()
        setupConstraints()
        indicatorLoad?.showIndicator(view: self.view)
    }
    
    func setupCollectionView() {
        //navigationItem.title = "Мужское"
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
            self.indicatorLoad?.hideIndicator(view: self.view)
            self.myCollectionView.reloadData()
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.indicatorLoad?.hideIndicator(view: self.view)
            self.showAlert("Ok", error)
        }
    }
    
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getDataSourceCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.mainCell, for: indexPath) as? MainCollectionViewCell {
            
            if let item = presenter?.getItem(index: indexPath.row) {
                cell.loadImage(imgStr: item.imgURL)
                cell.configureCell(itemCell: item)
            }
                return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (presenter?.getDataSourceCount() ?? 0) - 5 &&  presenter?.getNextPage() ?? 0 > 1 {
            presenter?.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailUrl = presenter?.getItem(index: indexPath.row).detailURL else { return }
        let detailViewController = DetailViewController()
        let detailViewPresenter = DetailViewPresenter(view: detailViewController, detailUrlStr: detailUrl)
        detailViewController.presenter = detailViewPresenter
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
