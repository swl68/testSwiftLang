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

protocol MainViewPreseneterProtocol: class {
    init(view: MainViewPresenterDelegate, typeKey: String)
    func getClothes()
    func getDataSource() -> [CompleteModel]
    func getDataSourceCount() -> Int
    func getNextPage() -> Int
    func getItem(index: Int) -> CompleteModel
    func loadMore()
}

class MainViewPresenter: MainViewPreseneterProtocol {
    
    private var model = MainViewControllerModel(nextPage: 1, isEmptyPage: false)
   // private let networkManager = NetworkManager.shared
    private let networkManager = NetworkManager()
    
    var typeKey = "shapki"// "bryuki" //"sumki"
    
    weak var view: MainViewPresenterDelegate?
    
    required init(view: MainViewPresenterDelegate, typeKey: String) {
        self.view = view
        self.typeKey = typeKey
        getClothes()
    }
    
    func getDataSource() -> [CompleteModel] {
        return model.dataSource
    }
    
    func getDataSourceCount() -> Int {
        return model.dataSource.count
    }
    
    func getNextPage() -> Int {
        return model.nextPage
    }
    
    func getItem(index: Int) -> CompleteModel {
        return model.dataSource[index]
    }
    
    func loadMore() {
        if !model.isEmptyPage {
            getClothes()
        }
    }
    
    private func updateView() {
        self.view?.updateData()
    }
    
    func getClothes() {
        print("updateDataSource")
        
        networkManager.getClothes(from: Endpoint.url, with: Keys.typeKey + typeKey + Keys.pageKey + "\(model.nextPage)" + Endpoint.api) { (result) in
            
            switch result {
            case .success(let items): self.prepareModel(items: items)
                print("success")
            print("Количество элементов \(items.items.count)")
            case .failed(let err): self.view?.showError(error: err)
                print("case failed")
            }
        }
    }
    
    private func prepareModel(items: Items) {
        model.isEmptyPage = !model.isEmptyPage
        if let page = items.nextPage {
            model.nextPage = page
            model.isEmptyPage = !model.isEmptyPage
        }
        items.items.forEach { model.dataSource.append(CompleteModel(item: $0)) }
        updateView()
    }
    
    deinit {
        print("deinit main presenter")
    }
    
}


