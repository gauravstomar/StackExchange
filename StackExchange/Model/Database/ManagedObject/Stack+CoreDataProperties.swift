//
//  Stack+CoreDataProperties.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 21/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//
//

import Foundation
import CoreData


extension Stack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stack> {
        return NSFetchRequest<Stack>(entityName: "Stack")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var tag: String?

}
