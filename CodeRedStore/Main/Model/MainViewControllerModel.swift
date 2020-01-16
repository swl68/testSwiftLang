//
//  Clothes.swift
//  CodeRedStore
//
//  Created by denisok on 03/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

protocol MainViewControllerModelDelegate: class {
    func dataChanged()
    func showError(error: String)
}

class MainViewControllerModel {
    
    weak var delegate: MainViewControllerModelDelegate?
    private var dataSource: [Item] = []
    
    
}
