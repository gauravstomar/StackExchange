//
//  Stack.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 20/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation
import CoreData

struct StackRO: Decodable {
    let question_id: Int
    let tags: [String]
    let title: String
}


struct StackViewModel {
    let name: String
    let tags: String
    var selected: Bool = false
}


//Mapping
extension StackViewModel {
    init(repo: StackRO) {
        self.name = repo.title
        self.tags = repo.tags.joined(separator:", ")
    }
}

@objc(Stack)
public class StackMO_: NSManagedObject {

}

extension StackMO_ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StackMO_> {
        return NSFetchRequest<StackMO_>(entityName: "Stack")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var tag: String?

}
