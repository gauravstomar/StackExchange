//
//  DatabaseManger.swift
//  StackExchange
//
//  Created by Gaurav S Tomar on 21/12/19.
//  Copyright © 2019 Gaurav S Tomar. All rights reserved.
//

import Foundation
import CoreData


class DataBaseManger {
    
    static func saveStackToDb(_ stack: StackRO, _ completionBlock : @escaping ()->()) {

        //TODO - Out of the scope - Use background context to improve performance
        let context = CoreDataStack.persistentContainer.viewContext
        
        let s = StackMO(context: context)
        s.name = stack.title
        s.id = Int64(stack.question_id)
        s.tag = stack.tags.joined(separator: ", ")
            
        CoreDataStack.saveContext()
        completionBlock()

    }
    
    
    static func loadStacksFromDb() -> [StackViewModel] {

        let context = CoreDataStack.persistentContainer.viewContext
        var viewModelArray = [StackViewModel]()
        
        let fr = NSFetchRequest<StackMO>(entityName: "Stack")
        
        do {
            let stacks : [StackMO] = try context.fetch(fr)
            if stacks.count > 0 {
                for stack in stacks {
                    viewModelArray.append(StackViewModel(maob: stack))
                }
            }
        } catch {
            print("Error fetching data from CoreData")
        }
        
        return viewModelArray
    
    }
    
}

