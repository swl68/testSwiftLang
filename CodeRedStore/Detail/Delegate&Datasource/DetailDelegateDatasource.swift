//
//  DetailDatasource.swift
//  CodeRedStore
//
//  Created by denisok on 19/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class DetailDelegateDatasource: NSObject, UITableViewDataSource, UICollectionViewDataSource, UITableViewDelegate, UICollectionViewDelegate {
    
    var presenter: DetailViewPresenterProtocol?
    var footerView: FooterView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getItems().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = presenter?.getItems()[indexPath.row] {
            
            switch item.type {
                
            case .detail:
                if let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.id, for: indexPath) as? DetailTableViewCell {
                    return detailCell
                }
                
            case .another:
                if let anotherCell = tableView.dequeueReusableCell(withIdentifier: AnotherColorTableViewCell.id, for: indexPath) as? AnotherColorTableViewCell {
                    return anotherCell
                }
                
            case .description:
                if let descriptionItem = item as? DescriptionModel, let descriptionCell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.id, for: indexPath) as? DescriptionTableViewCell {
                    descriptionCell.configureCell(item: descriptionItem)
                    return descriptionCell
                }
                
            case .size:
                if let sizeCell = tableView.dequeueReusableCell(withIdentifier: SizeTableViewCell.id, for: indexPath) as? SizeTableViewCell {
                    return sizeCell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let item = presenter?.getItems()[indexPath.row] {
            switch item.type {
            case .detail:
                return 480
            case .another:
                return 80
            case .description:
                return UITableView.automaticDimension
            case .size:
                return 80
            }
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.sectionFooterHeight = 60
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let detailCell = cell as? DetailTableViewCell {
            detailCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, for: indexPath.row)
        } else if let anotheCell = cell as? AnotherColorTableViewCell {
            anotheCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, for: indexPath.row)
        } else if let sizeCell = cell as? SizeTableViewCell {
            sizeCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, for: indexPath.row)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.getItems()[collectionView.tag].rowItem ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let item = presenter?.getItems()[collectionView.tag] {
            
            switch item.type {
            case .detail:
                
                if let item = item as? PhotoModel, let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPhotoCollectionViewCell.id, for: indexPath) as? DetailPhotoCollectionViewCell {
                    let photoStr = item.photoItems[indexPath.section]
                    detailCell.loadImage(imgStr: photoStr)
                    return detailCell
                }
                
            case .another:
                
                if let item = item as? AnotherModel, let anotherCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSizeCollectionViewCell.id, for: indexPath) as? DetailSizeCollectionViewCell {
                    let anotherStr = item.anotherItems[indexPath.section]
                    anotherCell.loadImage(imgStr: anotherStr)
                    return anotherCell
                }
                
            case .size:
                
                if let sizeModel = item as? SizeModel, let sizeCell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.id, for: indexPath) as? SizeCollectionViewCell {
                    let itm = sizeModel.size[indexPath.section]
                    
                    if sizeModel.index == indexPath.section {
                        sizeCell.isSelected = true
                        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
                    } else {
                        sizeCell.isSelected = false
                    }
                    sizeCell.configureCell(size: itm)
                    
                    return sizeCell
                }
                
            default:
                break
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("did select item collection")
        
        if let item = presenter?.getItems()[collectionView.tag] {
            
            switch item.type {
                
            case .size:
                if let sizeModel = item as? SizeModel {
                    sizeModel.index = indexPath.section
                    sizeModel.isSelectedCell = true
                    print("выбрал элемнент секции \(indexPath.section)")
                }
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        print("did deselect item collection")
        
        if let item = presenter?.getItems()[collectionView.tag] {
            
            switch item.type {
            case .size:
                if let sizeModel = item as? SizeModel {
                    sizeModel.isSelectedCell = false
                    sizeModel.index = nil
                    print("снял выбор с элемнента секции \(indexPath.section)")
                }
            default:
                break
            }
        }
    }
    
}
