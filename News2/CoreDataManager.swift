//
//  CoreDataManager.swift
//  News2
//
//  Created by MacBook on 4/20/23.
//

import Foundation
import CoreData

//more explanation around coreData and these computed vars
final class CoreDataManager: NSObject {
    private let modelFileName = "ArticlesDataModel"
    // shared is a singleton, instance of the database that is created only once and can be used to access all methods from the database class, a relationship like using the dot notation with ViewModel and View
    static let shared = CoreDataManager()
    private var storeIsNotLoad = true
    //creating the persistantContainer compted variable using the name of our database
     lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelFileName)
        return container
    }()
    //
    lazy var mainMOC: NSManagedObjectContext = {
        let managedObjectContext = persistentContainer.viewContext
        managedObjectContext.automaticallyMergesChangesFromParent = true
        managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        managedObjectContext.undoManager = nil
        return managedObjectContext
    }()

    var writeMOC: NSManagedObjectContext {
        let backgroundMOC = persistentContainer.newBackgroundContext()
        backgroundMOC.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundMOC.undoManager = nil
        return backgroundMOC
    }
    
    func loadStores(completion:(() -> Void)? = nil) {
        guard storeIsNotLoad else {
            completion?()
            return
        }
        persistentContainer.loadPersistentStores { [weak self] (desciption, error) in
            guard let self = self else {
                completion?()
                return
            }
            if let error = error {
                fatalError(error.localizedDescription)
            }
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            self.storeIsNotLoad = false
            completion?()
        }
    }
}

