//
//  NetworkManager.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 20/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation

protocol NetworkingService {
    @discardableResult func searchStacks(withQuery query: String, completion: @escaping ([StackRO]) -> ()) -> URLSessionDataTask
}


final class NetworkManager: NetworkingService {
    
    private let session = URLSession.shared
    
    @discardableResult
    func searchStacks(withQuery query: String, completion: @escaping ([StackRO]) -> ()) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle=\(query)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                    let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                        completion([])
                        return
                }
                
                completion(response.items)
                
            }
        }
        task.resume()
        return task
    }
    
}

fileprivate struct SearchResponse: Decodable {
    let items: [StackRO]
}
