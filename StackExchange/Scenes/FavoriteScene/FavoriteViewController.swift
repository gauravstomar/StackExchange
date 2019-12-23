//
//  FavoriteViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private let viewModel = FavoriteViewModels()
    private var data: [StackViewModel]?


    override func viewWillAppear(_ animated: Bool) {
        data = viewModel.listingData
        tableView.reloadData()
    }

}


extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.titleLabel.text = data[indexPath.row].name
        cell.tagsLabel.text = data[indexPath.row].tags
        return cell
    }
    
}


class FavoriteCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!

}
