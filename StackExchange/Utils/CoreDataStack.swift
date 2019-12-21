//
//  CoreDataStack.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 21/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {

    private init() {
        
    }
    
    static var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "StackExchange")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
    }()
 
    class func saveContext () {
        
        let context = CoreDataStack.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
}
