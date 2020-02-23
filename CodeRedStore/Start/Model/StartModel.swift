//
//  StartModel.swift
//  CodeRedStore
//
//  Created by denisok on 31/01/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

class StartModel {
    
    var isMan: Bool = true
    
    var dict: [String : String] {
        return isMan ? Constant.menClothes : Constant.womenClothes
    }
    
    // Передаем "Куртки мужские" получаем "muzhskie-kurtki"
    func getKeyClothesFromDict(for key: String) -> String {
        var value: String = ""
        for (keyDict, valueDict) in dict {
            if keyDict == key {
                value = valueDict
            }
        }
        return value
    }
    
    // Передаем словарь мужской или женской одежды получаем массив названий
    func getTypeClothes() -> [String] {
        var array: [String] = []
        dict.forEach { (values) in
            array.append(values.key)
        }
        return array
    }

}
