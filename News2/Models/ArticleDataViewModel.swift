//
//  ArticleDataViewModel.swift
//  News2
//
//  Created by MacBook on 4/17/23.
//

import Foundation
import CoreData

class ArticleDataViewModel : ObservableObject {
    @Published var article: ArticleDataBase
    let context: NSManagedObjectContext
    init(provider: CoreDataManager, article: ArticleDataBase? = nil){
        self.context = provider.mainMOC
        self.article = ArticleDataBase(context: self.context)
        provider.loadStores()
    }
    
    func saveContext()  {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error  {
                fatalError("Error saving context :\(error)")
            }
        }
    }
}
