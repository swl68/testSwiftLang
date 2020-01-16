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
}

protocol CellModelItem {
    var type: CellModelType { get }
    var rowItem: Int { get }
    var sectionTitle: String { get }
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
    
    var sectionTitle: String {
        return "Detail info"
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
    
    var sectionTitle: String {
        return "Another color"
    }
    
    var rowItem: Int {
        return anotherItems.count
    }
    
    init(anotherItems: [String]) {
        self.anotherItems = anotherItems
    }
}
