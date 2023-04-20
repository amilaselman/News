//
//  ArticleDataBase.swift
//  News2
//
//  Created by MacBook on 4/17/23.
//

import Foundation
import CoreData

class ArticleDataBase: NSManagedObject, Identifiable {

        @NSManaged public var id: UUID
        @NSManaged public var authorDB: String?
        @NSManaged public var titleDB: String?
        @NSManaged public var idSourceDB: String?
        @NSManaged public var nameSourceDB: String?
        @NSManaged public var descriptionDB: String?
        @NSManaged public var contentDB: String?
        @NSManaged public var publishedAtDB: String?
        @NSManaged public var urlDB: String?
        @NSManaged public var urlToImageDB: String?

    override func awakeFromInsert() {
        super.awakeFromInsert()
    }

}

extension ArticleDataBase {
    private static var articleFetchRequest: NSFetchRequest<ArticleDataBase> {
        NSFetchRequest(entityName: "ArticleDB")
    }

    static func all() -> NSFetchRequest<ArticleDataBase> {
        let request: NSFetchRequest<ArticleDataBase> = articleFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \ArticleDataBase.publishedAtDB, ascending: true)
        ]
        return request
    }
}
