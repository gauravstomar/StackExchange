//
//  ListingViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    private let viewModel = ListingViewModel(networkingService: NetworkManager())
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    
    private var data: [StackViewModel]?

    
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
        viewModel.didUpdateStack = { [weak self] repos in
            guard let strongSelf = self else { return }
            strongSelf.data = repos
            strongSelf.tableView.reloadData()
        }
        viewModel.didSelecteStack = { [weak self] id in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        cell.titleLabel.text = data[indexPath.row].name
        cell.tagsLabel.text = data[indexPath.row].tags
        return cell
    }
    
}

extension ListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
    
}

extension ListingViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didChangeQuery(searchText)
    }
    
}


class ListingCell: UITableViewCell {
    
    @IBOutlet var favButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!

}
