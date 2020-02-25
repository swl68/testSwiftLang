//
//  DetailViewModel.swift
//  CodeRedStore
//
//  Created by denisok on 13/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation
import UIKit

enum CellModelType {
    case detail
    case another
    case description
}

protocol CellModelItem {
    var type: CellModelType { get }
    var rowItem: Int { get }
}

extension CellModelItem {
    var rowItem: Int {
        return 1
    }
}


class PhotoModel: CellModelItem {
    
    var photoItems: [String]
    
    var type: CellModelType {
        return .detail
    }
    
    var rowItem: Int {
        return photoItems.count
    }
    
    init(photoItems: [String]) {
        self.photoItems = photoItems
    }
}

class AnotherModel: CellModelItem {
    
    var anotherItems: [String]
    
    var type: CellModelType {
        return .another
    }
    
    var rowItem: Int {
        return anotherItems.count
    }
    
    init(anotherItems: [String]) {
        self.anotherItems = anotherItems
    }
}

class DescriptionModel: CellModelItem {
    var description: String
    var name: String
    var brand: String
    var coast: String
    
    var type: CellModelType {
        return .description
    }
    
    init(description: String, name: String, brand: String, coast: String) {
        self.description = description
        self.name = name
        self.brand = brand
        self.coast = coast
    }
}

