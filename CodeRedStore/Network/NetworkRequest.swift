//
//  NetworkService.swift
//  CodeRedStore
//
//  Created by denisok on 29/11/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    typealias resultRequest = (data: Data?, response: URLResponse?, error: Error?)
    
    private func createRequest(from url: URL, with parameters: String) -> URLRequest {
        guard let postData = parameters.data(using: .utf8) else { return URLRequest(url: url) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        return request
    }
    
    func request(from url: URL, with parameters: String, completion: @escaping (resultRequest) -> () ) {
        //guard let url = URL(string: Endpoint.url) else { return }
        let request = createRequest(from: url, with: parameters)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            completion((data, httpResponse, error))
        }.resume()
    }
}
