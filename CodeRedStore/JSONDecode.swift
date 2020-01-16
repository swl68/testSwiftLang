//
//  JSONDecode.swift
//  CodeRedStore
//
//  Created by denisok on 27/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

// MARK: - Main
struct Main: Decodable {
    let success: Bool?
    let outputScenario: String?
    let data: Output?
    let stateToken: String?
    let cookies: [Cooky]?
}

struct Output: Decodable {
    var detailItem: DetailItem?
    var items: Items?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            items = try container.decode(Items.self)
        } catch {
            detailItem = try container.decode(DetailItem.self)
        }
    }
}


// MARK: - Items
struct Items: Decodable {
    let items: [Item]
    let nextPage: Int?
}

// MARK: - Item
struct Item: Decodable {
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

// MARK: - DetailItem
struct DetailItem: Decodable {
    let anotherColorUrls: [String]?
    let imgURLArray, imgURLAnotherColor: [String]?
    let size: [String]?
    let name, brand, coast: String?
    let dataDescription: String

    enum CodingKeys: String, CodingKey {
        case anotherColorUrls
        case imgURLArray = "imgUrlArray"
        case imgURLAnotherColor = "imgUrlAnotherColor"
        case size
        case dataDescription = "description"
        case name, brand, coast
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
struct Cooky: Decodable {
    let key, value, domain, path: String?
    let hostOnly: Bool?
    let creation, lastAccessed: String?
    let expires: String?
    let maxAge: Int?
}

