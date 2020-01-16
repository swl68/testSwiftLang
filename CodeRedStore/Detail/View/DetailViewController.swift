//
//  DetailViewController.swift
//  CodeRedStore
//
//  Created by denisok on 10/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailViewPresenterProtocol?
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraint()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .white
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.detailCell)
        tableView.register(AnotherColorTableViewCell.self, forCellReuseIdentifier: AnotherColorTableViewCell.detailCell)
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    deinit {
        print("deinit detail")
    }
}

extension DetailViewController: DetailViewProtocol {
  
    func showError(error: String) {
        showAlert("ok", error)
    }
    
    func dataChanged() {
        self.tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getItems().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = presenter?.getItems()[indexPath.row]
        
        switch item?.type {
            
        case .detail:
            print("tableviewcell detail")
            if let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.detailCell, for: indexPath) as? DetailTableViewCell {
                return detailCell
            }
            
        case .another:
            print("tableviewcell another")
            if let anotherCell = tableView.dequeueReusableCell(withIdentifier: AnotherColorTableViewCell.detailCell, for: indexPath) as? AnotherColorTableViewCell {
                return anotherCell
            }
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = presenter?.getItems()[indexPath.row]
        switch item?.type {
        case .detail:
            return 480
        case .another:
            return 80
        default:
            return UITableView.automaticDimension
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
}


extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if let detailCell = cell as? DetailTableViewCell {
            detailCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, for: indexPath.row)
        } else {
            if let anotheCell = cell as? AnotherColorTableViewCell {
                anotheCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, for: indexPath.row)
            }
        }
    }
}



extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.getItems()[collectionView.tag].rowItem ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = presenter?.getItems()[collectionView.tag]
        
        switch item?.type {
        case .detail:
            
            if let item = item as? PhotoModel, let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPhotoCollectionViewCell.galeriCell2, for: indexPath) as? DetailPhotoCollectionViewCell {
                let photoStr = item.photoItems[indexPath.section]
                detailCell.loadImage(imgStr: photoStr)
                return detailCell
            }
            
        case .another:
            
            if let item = item as? AnotherModel, let anotherCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSizeCollectionViewCell.galeriCell, for: indexPath) as? DetailSizeCollectionViewCell {
                let anotherStr = item.anotherItems[indexPath.section]
                anotherCell.loadImage(imgStr: anotherStr)
                
                return anotherCell
            }
            
        default:
            break
        }
        return UICollectionViewCell()
    }
}


extension DetailViewController: UICollectionViewDelegate {
    
}


