//
//  JSONDecode.swift
//  CodeRedStore
//
//  Created by denisok on 27/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

// MARK: - Main
struct Main: Codable {
    let success: Bool?
    let outputScenario: String?
    let data: Items?
    let stateToken: String?
    let cookies: [Cooky]?
}

// MARK: - Items
struct Items: Codable {
    let items: [Item]
    let nextPage: Int?
}

// MARK: - Item
struct Item: Codable {
    let size: [String]?
    let imgURL: String?
    let itemDescription, coast, detailURL: String?
    let brand: String?

    enum CodingKeys: String, CodingKey {
        case size
        case imgURL = "imgUrl"
        case itemDescription = "description"
        case coast
        case detailURL = "detailUrl"
        case brand
    }
}

//enum Brand: String, Codable {
//    case empty = ""
//    case codeRedSport = "CodeRed Sport"
//    case codered = "CODERED"
//    case cor = "COR"
//}

//enum Size: String, Codable {
//    case empty = ""
//    case l = "L"
//    case m = "M"
//    case s = "S"
//    case xl = "XL"
//    case mL = "M-L"
//    case xlXxl = "XL-XXL"
//    case xs = "XS"
//    case xsS = "XS-S"
//}

// MARK: - Cooky
struct Cooky: Codable {
    let key, value, domain, path: String
    let hostOnly: Bool
    let creation, lastAccessed: String
}

