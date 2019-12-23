//
//  Stack.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 20/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation

struct StackRO: Decodable {
    let question_id: Int
    let tags: [String]
    let title: String
}


struct StackViewModel {
    let name: String
    let tags: String
}


//Mapping
extension StackViewModel {
    init(repo: StackRO) {
        self.name = repo.title
        self.tags = repo.tags.joined(separator:", ")
    }
}

