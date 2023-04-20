//
//  ArticleDataBase+CoreDataClass.swift
//  News2
//
//  Created by MacBook on 4/14/23.
//
//

import Foundation
import CoreData


//public class ArticleDataBase: NSManagedObject {
//    
//    static var container: NSPersistentContainer {
//        let container = NSPersistentContainer(name: "ArticleDataModel")
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error as NSError? {
//                fatalError("Container load failed: \(error)")
//            }
//        }
//        return container
//    }
//    
//    func saveContext() {
//        let context = ArticleDataBase.container.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//                print("Saved data")
//            } catch let error {
//                fatalError("Data not saved \(error)")
//            }
//        }
//    }
//}
