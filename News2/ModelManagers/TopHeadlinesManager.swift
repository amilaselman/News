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
                self.addItem(article: item, context: context)
                if context.hasChanges {
                    do {
                        try context.save()
                        completionHandler(true)
                    } catch let error {
                        print("Unable to save context: \(error)")
                        completionHandler(false)
                    }
                }
            }
        }
    }
    
    func findOrCreate(article: Article, context: NSManagedObjectContext) -> ArticleDB {
        let dataBaseArticle = fetchHeadlines()
        for item in dataBaseArticle {
            if item.urlDB  != article.url.absoluteString {
                return item
            }
        }
        //ako ne postoji kreiraj novi
        let newArticle = ArticleDB(context: context)
          return newArticle
    }
    
   
    func addItem(article: Article, context: NSManagedObjectContext) {
        //check da li ima vec u bazi article sa istim url kao iz apija ???  da je ArticleDB.urlDB == Article.url
        let item = findOrCreate(article: article, context: context)
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
    
    
    //povlacenje iz baze
    func fetchHeadlines() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.all()
        return (try? context.fetch(request)) ?? []
    }
    
//
//
//
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
    func predicateUrl(for url: String) -> NSPredicate {
        NSPredicate(format: "@K == %@", #keyPath(ArticleDB.urlDB), url )
    }
    
   
}


