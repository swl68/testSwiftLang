//
//  NetworkManager.swift
//  CodeRedStore
//
//  Created by denisok on 29/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failed(String)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    let networkRequest = NetworkRequest.shared
    
    func getClothes(with parametrs: String, completion: @escaping(Result<Items>) -> () ) {
        
        networkRequest.request(with: parametrs) { (resultRequest) in
            
            if resultRequest.error != nil {
                guard let err = resultRequest.error?.localizedDescription else { return }
                completion(Result.failed(err))
            } else {
                guard let rowData = resultRequest.data else { return }
                do {
                    let decodableData = try JSONDecoder().decode(Main.self, from: rowData)
                    guard let items = decodableData.data else { return }
                    completion(Result.success(items) )
                } catch {
                    completion(Result.failed("Ошибка декодирования, сообщите администратору"))
                }
            }
        }
    }
}
