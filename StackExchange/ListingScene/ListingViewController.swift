//
//  ListingViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    private let viewModel = ListingViewModel(networkingService: NetworkingAPI())
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchController: UISearchBar!
    
    private var data: [ResultViewModel]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
    }
    
    private func setupViewModel() {
        viewModel.isRefreshing = { loading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        viewModel.didUpdateResult = { [weak self] repos in
            guard let strongSelf = self else { return }
            strongSelf.data = repos
            strongSelf.tableView.reloadData()
        }
        viewModel.didSelecteResult = { [weak self] id in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: "\(id)", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            strongSelf.present(alertController, animated: true, completion: nil)
        }
    }
    
}


extension ListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}

extension ListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension ListingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.didChangeQuery(searchController.searchBar.text ?? "")
    }
}
