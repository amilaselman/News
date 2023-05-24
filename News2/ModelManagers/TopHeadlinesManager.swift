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




class TopHeadlinesManager {
    private let coreManager = CoreDataManager.shared
    func getData(completionHandler: @escaping (Bool) -> ()) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9044fe8605c447b587a2adc404452dd5"
        guard let url = URL(string: urlString) else { return} // check za kasnije
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let recievedData = data {
                do {
                    let items = try JSONDecoder().decode(News.self, from: recievedData)
                    self.addToDatabase(articles: items.articles) { success in
                        completionHandler(success)
                    }
                } catch {
                    completionHandler(false)
                }
            }
        }.resume()
    }
    
    func addToDatabase(articles: [Article], completionHandler: @escaping(Bool) -> ()) {
        let context = self.coreManager.writeMOC
        context.perform {//perform makes sure this process happens on the main thread
            for item in articles {
                self.insertItem(article: item, context: context)
            }
            context.saveContext { saved in
                completionHandler(saved)
                }
            }
        }
    
    //some issues while inserting core data ?
    //that cause the error: mutated while being enumerated
    func insertItem(article: Article, context: NSManagedObjectContext) {
        let item = findOrCreate(url: article.url.absoluteString, context: context)
        //if found, update it
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
    func findOrCreate(url: String, context: NSManagedObjectContext) -> ArticleDB {
        let article = fetchByUrl(by: url,context: context)// use predicate by: url
        if let article = article { //unwrapping
            article.isTop = true
            return article
        } else {
            let newArticle = ArticleDB(context: context)
            newArticle.isTop = true
            return newArticle
        }
    }
    
    //fetches all headlines from dataBase, but from which api?
    func fetchTopHeadlines() -> [ArticleDB] {
        let context = self.coreManager.mainMOC
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == true", #keyPath(ArticleDB.isTop))
        return (try? context.fetch(request)) ?? []
    }
    //fetches headlines by url from database, url is used as an id because it is unique
    //error while fetching, but  why?
    func fetchByUrl(by url: String, context: NSManagedObjectContext) -> ArticleDB? {
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ArticleDB.urlDB), url)
        return try? context.fetch(request).first
    }
    //fetches headlines from database that are marked as favorite; function used in ViewModel
    func fetchFavorites(context: NSManagedObjectContext) -> [ArticleDB] {
        let request = ArticleDB.articleFetchRequest
        request.predicate = NSPredicate(format: "%K == true", #keyPath(ArticleDB.isFavorite))
        return (try? context.fetch(request)) ?? []
    }
    
    //creates a new instance of database type and sets the atribute isFavorite to true
    //used in ViewModel
    //must find the article that isFavorite == true in database
    func addOrRemoveTopBookmark(article: ArticleDB, context: NSManagedObjectContext) {
        context.perform {
            article.isFavorite.toggle()
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    print("Unable to save context : \(error)")
                }
            }
        }
    }
    
}//end of class


