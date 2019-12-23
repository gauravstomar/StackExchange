//
//  FavoriteViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(DataBaseManger.loadStacksFromDb())
        
    }


}

