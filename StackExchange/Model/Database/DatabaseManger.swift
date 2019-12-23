//
//  DatabaseManger.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 21/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation

class DataBaseManger {
    
    class func saveStackToDb(_ completionBlock : @escaping ()->()) {

        //TODO - Out of the scope - Use background context to improve performance
//        let context = CoreDataStack.persistentContainer.viewContext
//        let car = Stack(context:context)
//        CoreDataStack.saveContext()
        completionBlock()

    }
    
    
    class func loadStacksFromDb() -> [StackViewModel] {

        let context = CoreDataStack.persistentContainer.viewContext
        var viewModelArray = [StackViewModel]()
//        do {
//            let stack : [Stack] = try context.fetch(Car.fetchRequest())
//            if stack.count > 0{
//                for car in cars{
//                    let viewModel = CarInfoViewModel(data: car)
//                    viewModelArray.append(viewModel!)
//                }
//            }
//        } catch {
//            print("Error fetching data from CoreData")
//        }
        
        return viewModelArray
    
    }
    
}

