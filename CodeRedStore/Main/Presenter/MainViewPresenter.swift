//
//  MainViewPresenter.swift
//  CodeRedStore
//
//  Created by denisok on 03/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

protocol MainViewPresenterDelegate: class {
    func updateData()
    func showError(error: String)
}

class MainViewPresenter {
   
    private var model = MainViewControllerModel(nextPage: 1, isEmptyPage: false)
    private let networkManager = NetworkManager.shared
    weak var delegate: MainViewPresenterDelegate?
    
    var typeKey = "shapki"// "bryuki" //"sumki"
    
    init() {
        updateDataSource()
    }
    
    func getDataSource() -> [Item] {
        return model.dataSource
    }
    
    func getDataSourceCount() -> Int {
        return model.dataSource.count
    }
    
    func getNextPage() -> Int {
        return model.nextPage
    }
    
    func getItem(index: Int) -> Item {
        return model.dataSource[index]
    }
    
    func loadMore() {
        if !model.isEmptyPage {
            updateDataSource()
        }
    }
    
    private func updateView() {
        self.delegate?.updateData()
    }
    
    private func updateDataSource() {
        print("updateDataSource")
        
        networkManager.getClothes(from: Endpoint.url, with: Keys.typeKey + typeKey + Keys.pageKey + "\(model.nextPage)" + Endpoint.api) { (result) in
            switch result {
            case .success(let items): self.prepareModel(items: items)
                print("success")
                
            case .failed(let err): self.delegate?.showError(error: err)
            }
        }
    }
    
    private func prepareModel(items: Items) {
        model.isEmptyPage = !model.isEmptyPage
        if let page = items.nextPage {
            model.nextPage = page
            model.isEmptyPage = !model.isEmptyPage
        }
        
        model.dataSource += items.items
        updateView()
    }
    
}

//extension MainViewPresenter: MainViewControllerModelDelegate {
//    func dataChanged() {
//        updateView()
//        print("update View in presenter")
//    }
//}
