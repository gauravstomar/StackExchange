//
//  ListingViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

final class ListingViewModel {
    // Outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateStack: (([StackViewModel]) -> Void)?
    var didSelecteStack: ((Int) -> Void)?
    
    private(set) var repos: [StackRO] = [StackRO]() {
        didSet {
            didUpdateStack?(repos.map { StackViewModel(repo: $0) })
        }
    }
    
    private let throttle = Throttle(minimumDelay: 0.3)
    private var currentSearchNetworkTask: URLSessionDataTask?
    private var lastQuery: String?
    
    // Dependencies
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    // Inputs
    func ready() {
        isRefreshing?(true)
        networkingService.searchStacks(withQuery: "swift") { [weak self] repos in
            guard let strongSelf  = self else { return }
            strongSelf.finishSearching(with: repos)
        }
    }
    
    func didChangeQuery(_ query: String) {
        guard query.count > 2,
            query != lastQuery else { return } // distinct until changed
        lastQuery = query
        
        throttle.throttle {
            self.startSearchWithQuery(query)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if repos.isEmpty { return }
        didSelecteStack?(repos[indexPath.item].question_id)
    }
    
    // Private
    private func startSearchWithQuery(_ query: String) {
        currentSearchNetworkTask?.cancel() // cancel previous pending request
        
        isRefreshing?(true)

        currentSearchNetworkTask = networkingService.searchStacks(withQuery: query) { [weak self] repos in
            guard let strongSelf  = self else { return }
            strongSelf.finishSearching(with: repos)
        }
    }
    
    private func finishSearching(with repos: [StackRO]) {
        isRefreshing?(false)
        self.repos = repos
    }

}
