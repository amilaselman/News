//
//  ArticleProvider.swift
//  News2
//
//  Created by MacBook on 4/17/23.
//

import Foundation
import CoreData

//class ArticleProvider {
//    static let shared = ArticleProvider()
//    private let container: NSPersistentContainer
//    var viewContext: NSManagedObjectContext {
//        container.viewContext
//    }
//    var newContext: NSManagedObjectContext {
//        container.newBackgroundContext()
//    }
//
//    private init() {
//        container = NSPersistentContainer(name: "ArticlesDataModel")
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        container.loadPersistentStores { _, error in
//            if let error {
//                fatalError("Unable to load store with error : \(error)")
//            }
//        }
//    }
//}
