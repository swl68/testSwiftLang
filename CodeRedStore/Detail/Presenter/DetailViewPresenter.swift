//
//  DetailPresenter.swift
//  CodeRedStore
//
//  Created by denisok on 10/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func showError(error: String)
    func dataChanged()
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, detailUrlStr: String)
    func getDetail()
    func getItems() -> [CellModelItem]
    func createBasket()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var detailUrlStr: String
   // var networkManager = NetworkManager.shared
    let networkManager = NetworkManager()
    
    var items : [CellModelItem] = []
    var sizeModel: SizeModel?
    var descriptionModel: DescriptionModel?
    var firstImgUrlStr: String = ""
       
    required init(view: DetailViewProtocol, detailUrlStr: String) {
        self.view = view
        self.detailUrlStr = detailUrlStr
        getDetail()
    }
    
    func getItems() -> [CellModelItem] {
        return items
    }
    
    func createSize() -> String {
        if let sizeModel = sizeModel {
            if let index = sizeModel.index {
                return sizeModel.size[index]
            }
        }
        return ""
    }
    
    func createBasket() {
        
        guard let descriptionModel = descriptionModel else { return }
        CoreDataStack.shared.createProduct(sizeItem: createSize(), descriptionModel: descriptionModel, imageStr: firstImgUrlStr)
    }
    
    private func prepareModel(model: DetailItem) {
        appendPhotoModel(model: model)
        appendAnotherModel(model: model)
        appendDescriptionModel(model: model)
        appendSizeModel(model: model)
    }
    
    private func appendAnotherModel(model: DetailItem) {
        if let another = model.imgURLAnotherColor {
            let anotherItm = AnotherModel(anotherItems: another)
            items.append(anotherItm)
        }
    }
    
    private func appendPhotoModel(model: DetailItem) {
        if let arrayImgStr = model.imgURLArray {
            firstImgUrlStr = arrayImgStr.first!
            let phtItem = PhotoModel(photoItems: arrayImgStr)
            items.append(phtItem)
        }
    }
    
    private func appendSizeModel(model: DetailItem) {
        if let itm = model.size {
            let sizeItm = SizeModel(size: itm)
            sizeModel = sizeItm
            items.append(sizeItm)
        }
    }
    
    private func appendDescriptionModel(model: DetailItem) {
        let descriptionItem = DescriptionModel(description: model.dataDescription, name: model.name, brand: model.brand, coast: model.coast)
        descriptionModel = descriptionItem
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
