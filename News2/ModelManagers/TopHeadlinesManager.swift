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
    
    
    func fetchHeadlines() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchByUrl(by url: String) -> ArticleDB? {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ArticleDB.urlDB), url)
        return try? context.fetch(request).first
    }
    
    func fetchFavorites() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == true", #keyPath(ArticleDB.isFavorite))
        return (try? context.fetch(request)) ?? []
    }
    
//    func predicateIsFavorite() -> NSPredicate {
//        NSPredicate(format: "@K == %@", #keyPath(ArticleDB.isFavorite))// kako oznacimo da je favorite true
//    }
    

//
//    func create(article: Article, context: NSManagedObjectContext ) {
//        let newArticle = ArticleDB(context: context)
//        newArticle.authorDB = article.author
//        newArticle.titleDB = article.title
//        newArticle.idSourceDB = article.source.id
//        newArticle.nameSourceDB = article.source.name
//        newArticle.descriptionDB = article.description
//        newArticle.contentDB = article.content
//        newArticle.publishedAtDB = article.publishedAt
//        newArticle.urlDB = article.url.absoluteString
//        newArticle.urlToImageDB = article.urlToImage?.absoluteString
//    }
//
    
    
   
}


