//
//  Clothes.swift
//  CodeRedStore
//
//  Created by denisok on 03/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

struct MainViewControllerModel {
    var dataSource: [CompleteModel] = []
    var nextPage: Int
    var isEmptyPage: Bool
}

struct CompleteModel {
    var size: [String]
    var imgURL: String
    var itemDescription: String
    var coast: String
    var detailURL: String
    var brand: String
    
    init(item: Item) {
        imgURL = item.imgURL ?? ""
        itemDescription = item.itemDescription ?? "Описание отсутствует"
        coast = item.coast ?? "Неизвестно"
        detailURL = item.detailURL ?? ""
        brand = item.brand ?? "Неизвестно"
        size = item.size ?? []
    }
}

