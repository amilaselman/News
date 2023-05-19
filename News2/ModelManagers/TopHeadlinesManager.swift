//
//  TopHeadlinesManager.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

//https://newsapi.org/v2/top-headlines?country=us&apiKey=9044fe8605c447b587a2adc404452dd5#
import Foundation
import CoreData
import SwiftUI

class TopHeadlinesManager  {
    private let coreManager = CoreDataManager.shared
    
    //my function
    func getData(completionHandler: @escaping (Bool) -> ()) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9044fe8605c447b587a2adc404452dd5#"
        guard let url = URL(string: urlString) else { return } // check za kasnije
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let recievedData = data {
                do {
                    let items = try JSONDecoder().decode(News.self, from: recievedData)
                    self.completeAdding(articles: items.articles) { success in
                        completionHandler(success)
                    }
                } catch {
                    completionHandler(false)
                }
            }
        }.resume()
    }
    
    
    func completeAdding(articles: [Article], completionHandler: @escaping(Bool) -> ()) {
        let context = self.coreManager.writeMOC
        context.perform {
            for item in articles {
                self.insertItem(article: item, context: context)
                self.updateFavorite(article: item)
            }
            if context.hasChanges {
                do {
                    try context.save()
                    completionHandler(true)
                } catch let error {
                    print("Unable to save context: \(error)")
                    completionHandler(false)
                }
            } else {
                completionHandler(true)
            }
        }
    }
    
    func findOrCreate(url: String, context: NSManagedObjectContext) -> ArticleDB {
        let article = fetchByUrl(by: url)// pozvati fju sa predicate za url
        if let article = article { //unwrappanje
            return article
        } else {
            let newArticle = ArticleDB(context: context)
            return newArticle
        }
    }
//    func updateFavorite(article: Article) {
//        let context = coreManager.writeMOC
//        context.perform {
//            let favorite = self.findFavorite()
//            favorite?.authorDB = article.author
//            favorite?.titleDB = article.title
//        }
//        if context.hasChanges {
//            do {
//                try? context.save()
//            } catch let error {
//                print("Unable to save context of favorite : \(error)")
//            }
//        }
//    }
    
//    func findFavorite() -> ArticleDB? {
//        let favorite = fetchFavorites()
//        return favorite.first
//
//    }
    func findFavorite() -> ArticleDB? {
        let favorites = fetchFavorites()
        for article in favorites {
            return article
        }
        return favorites.first
    }

    //calls  findFavorite() and updates it
    func updateFavorite(article: Article) {
        let context = coreManager.writeMOC
        context.perform {
            let favorite = self.findFavorite()
            favorite?.authorDB = article.author
            favorite?.titleDB = article.title
            favorite?.urlDB = article.url.absoluteString
            favorite?.publishedAtDB = article.publishedAt
            favorite?.urlToImageDB = article.urlToImage?.absoluteString
            favorite?.contentDB = article.content
            favorite?.idSourceDB = article.source.id
            favorite?.nameSourceDB = article.source.name
            favorite?.descriptionDB = article.description
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("Unable to save context: \(error)")
            }
        }
        
    }
    func insertItem(article: Article, context: NSManagedObjectContext) {
        //check da li ima vec u bazi article sa istim url kao iz apija ???  da je ArticleDB.urlDB == Article.url
        let item = findOrCreate(url: article.url.absoluteString, context: context)
        //ako ga nadje, treba ga update-ovat
        item.authorDB = article.author
        item.titleDB = article.title
        item.idSourceDB = article.source.id
        item.nameSourceDB = article.source.name
        item.descriptionDB = article.description
        item.contentDB = article.content
        item.publishedAtDB = article.publishedAt
        item.urlDB = article.url.absoluteString
        item.urlToImageDB = article.urlToImage?.absoluteString
        
    }
    
//fetches all headlines from dataBase, but from which api?
    //fetchAllHeadlines() does the same, uses the same MOC,
    //
    func fetchHeadlines() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        return (try? context.fetch(request)) ?? []
    }
//fetches headlines by url; used as id because it's unique
    func fetchByUrl(by url: String) -> ArticleDB? {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ArticleDB.urlDB), url)
        return try? context.fetch(request).first
    }
//fetches headlines marked as isFavorite = true
    func fetchFavorites() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == true", #keyPath(ArticleDB.isFavorite))
        return (try? context.fetch(request)) ?? []
    }
    
    func findAndUpdate() -> ArticleDB {
        let context = self.coreManager.writeMOC
        let newFavorites = fetchFavorites()
        //update the rest of the atributes for newFavorite
        for item in newFavorites {
            item.isFavorite = true
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    print("Unable to save context: \(error)")
                }
            }
        }
        return newFavorites.first!

    }
//    func findAndUpdate() -> ArticleDB? {
//        let context = self.coreManager.writeMOC
//      //  let newFavorite = fetchFavorites()
//        let favorite = self.findFavorite()
//        context.perform {
//            favorite?.isFavorite = true
//                }
//                if context.hasChanges{
//                    do {
//                        try context.save()
//                    } catch let error {
//                        print("Unable to save context : \(error)")
//                    }
//                }
//        return favorite
//    }

    
    
    
   
}//end of class


