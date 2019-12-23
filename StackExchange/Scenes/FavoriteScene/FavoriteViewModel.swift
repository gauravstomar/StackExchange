//
//  FavoriteViewController.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 19/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import UIKit

final class FavoriteViewModels {

    private var data: [StackViewModel]?

    var listingData: [StackViewModel] {
        return DataBaseManger.loadStacksFromDb()
    }
    
}

