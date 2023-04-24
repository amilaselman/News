//
//  ArticleDataViewModel.swift
//  News2
//
//  Created by MacBook on 4/17/23.
//

import Foundation
import CoreData

class ArticleDataViewModel : ObservableObject {
    @Published var article: ArticleDB
    let context: NSManagedObjectContext
    init(provider: CoreDataManager, article: ArticleDB? = nil){
        self.context = provider.mainMOC
        self.article = ArticleDB(context: self.context)
        
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
