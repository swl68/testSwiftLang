//
//  DetailPresenter.swift
//  CodeRedStore
//
//  Created by denisok on 10/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation
import UIKit

// output protocol
protocol DetailViewProtocol: class {
    func showError(error: String)
    func dataChanged()
}

// input protocol
protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, detailUrlStr: String)
    func getDetail()
    func getItems() -> [CellModelItem]
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var detailUrlStr: String
    var networkManager = NetworkManager.shared
    
    var items : [CellModelItem] = []
       
    required init(view: DetailViewProtocol, detailUrlStr: String) {
        self.view = view
        self.detailUrlStr = detailUrlStr
        getDetail()
    }
    
    func getItems() -> [CellModelItem] {
        return items
    }
    
    private func prepareModel(model: DetailItem) {
        appendPhotoModel(model: model)
        appendAnotherModel(model: model)
        appendDescriptionModel(model: model)
    }
    
    private func appendAnotherModel(model: DetailItem) {
        if let another = model.imgURLAnotherColor {
            let anotherItm = AnotherModel(anotherItems: another)
            items.append(anotherItm)
        }
    }
    
    private func appendPhotoModel(model: DetailItem) {
        if let img = model.imgURLArray {
            let phtItem = PhotoModel(photoItems: img)
            items.append(phtItem)
        }
    }
    
    private func appendDescriptionModel(model: DetailItem) {
        let descriptionItem = DescriptionModel(description: model.dataDescription, name: model.name, brand: model.brand, coast: model.coast)
        items.append(descriptionItem)
    }
    
    func getDetail() {
        
        networkManager.getDetailClothes(from: Endpoint.detailUrl + detailUrlStr + Endpoint.api, with: "") { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let item):
                self.prepareModel(model: item)
                
                self.view?.dataChanged()
                    
                case .failed(let error):
                    self.view?.showError(error: error)
                }
            }
        }
    }
    
    deinit {
        print("deinit detail presenter")
    }
    
    
}
