//
//  ArticleDataBase.swift
//  News2
//
//  Created by MacBook on 4/17/23.
//

import Foundation
import CoreData

class ArticleDB: NSManagedObject, Identifiable {

        //@NSManaged public var id: UUID
        @NSManaged public var isFavorite: Bool
        @NSManaged public var isTop: Bool
        @NSManaged public var authorDB: String?
        @NSManaged public var titleDB: String?
        @NSManaged public var idSourceDB: String?
        @NSManaged public var nameSourceDB: String?
        @NSManaged public var descriptionDB: String?
        @NSManaged public var contentDB: String?
        @NSManaged public var publishedAtDB: String?
        @NSManaged public var urlDB: String?
        @NSManaged public var urlToImageDB: String?
    var url: URL? {
        guard let url = urlDB else { return nil }
         return URL(string: url)
    }
    
    var urlToImage: URL? {
        URL(string: urlToImageDB ?? String())
    }
    override func awakeFromInsert() {
        super.awakeFromInsert()
    }

}

extension ArticleDB {
    static var articleFetchRequest: NSFetchRequest<ArticleDB> {
        NSFetchRequest(entityName: "ArticleDB")
        
    }
    
    
}
