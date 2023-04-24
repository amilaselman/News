//
//  CoreDataManager.swift
//  News2
//
//  Created by MacBook on 4/20/23.
//

import Foundation
import CoreData



final class CoreDataManager: NSObject {
    private let modelFileName = "ArticlesDataModel"
    private let modelFileExtension = "momd"
    private let dbFilename = "ArticlesDataModel.sqlite"
    static let shared = CoreDataManager()
    
    private var storeIsNotLoad = true
    
     lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelFileName)
        return container
    }()
    
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

