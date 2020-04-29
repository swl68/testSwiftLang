//
//  BasketPresenter.swift
//  CodeRedStore
//
//  Created by denisok on 03/04/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import Foundation

protocol BasketViewPresenter: class {
    func updateView()
}

class BasketPresenter {
    
    var basketMdoel = BasketModel()
    var view: BasketViewPresenter!
    
    init() {
        print(basketMdoel.datasource.count)
    }
    
    func getBasket(for index: Int) -> Basket {
        return basketMdoel.datasource[index]
    }
    
    func getBasketCount() -> Int {
        return basketMdoel.datasource.count
    }
    
    deinit {
        print("deinit presenter basket")
    }
    
}

extension BasketPresenter: BasketModelDelegate {
    func dataChanged() {
        print("update view in presenetr")
        view.updateView()
    }
    
}


