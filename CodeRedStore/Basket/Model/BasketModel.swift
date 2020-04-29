//
//  BasketModel.swift
//  CodeRedStore
//
//  Created by denisok on 16/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

//import CoreData

protocol BasketModelDelegate: class {
    func dataChanged()
}

class BasketModel {
    
    weak var delegate: BasketModelDelegate?
    
    var datasource: [Basket] = []
    
    init() {
        datasource = CoreDataStack.shared.fetchData()
        delegate?.dataChanged()
    }
    
}
