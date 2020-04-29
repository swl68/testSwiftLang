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
    
    let networkRequest: NetworkRequest
    
    init(networkRequest: NetworkRequest = NetworkRequest()) {
        self.networkRequest = networkRequest
    }
    
    func getClothes(from urlStr: String, with parametrs: String, completion: @escaping(Result<Items>) -> () ) {
        
        guard let url = URL(string: urlStr) else { return }
        
        networkRequest.request(from: url, with: parametrs) { (resultRequest) in

            if resultRequest.error != nil {
                guard let err = resultRequest.error?.localizedDescription else { return }
                completion(Result.failed(err))
            } else {
                guard let rowData = resultRequest.data else { return }
                do {
                    let decodableData = try JSONDecoder().decode(Main.self, from: rowData)
                    
                    if let items = decodableData.data?.items {
                        completion(Result.success(items) )
                    } else {
                        completion(Result.failed(Errors.noResults.rawValue))
                    }
                } catch {
                    completion(Result.failed(Errors.decodeError.rawValue))
                }
            }
        }
    }
    
    func getDetailClothes(from urlStr: String, with parametrs: String, completion: @escaping(Result<DetailItem>) -> () ) {
        
        guard let url = URL(string: urlStr) else { return }
        
        networkRequest.request(from: url, with: parametrs) { (resultRequest) in
            
            if resultRequest.error != nil {
                guard let err = resultRequest.error?.localizedDescription else { return }
                completion(Result.failed(err))
            } else {
                guard let rowData = resultRequest.data else { return }
                do {
                    let decodableData = try JSONDecoder().decode(Main.self, from: rowData)
                    guard let item = decodableData.data?.detailItem else { return }
                    
                    completion(Result.success(item) )
                } catch {
                    completion(Result.failed(Errors.decodeError.rawValue))
                }
            }
        }
    }
    
}
