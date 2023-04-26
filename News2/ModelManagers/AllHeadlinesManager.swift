//
//  AllHeadlinesManager.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation
import CoreData

class AllHeadlinesManager{
    private let coreManager = CoreDataManager.shared
    
    func getData(completionHandler: @escaping (Bool) -> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=9044fe8605c447b587a2adc404452dd5"
        guard let url = URL(string: urlString) else { return} // check za kasnije
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
            }
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
    
    func addItem(article: Article, context: NSManagedObjectContext) {
        let newArticle = ArticleDB(context: context)
        // newArticle.id = UUID()
        newArticle.authorDB = article.author
        newArticle.titleDB = article.title
        newArticle.idSourceDB = article.source.id
        newArticle.nameSourceDB = article.source.name
        newArticle.descriptionDB = article.description
        newArticle.contentDB = article.content
        newArticle.publishedAtDB = article.publishedAt
        newArticle.urlDB = article.url.absoluteString
        newArticle.urlToImageDB = article.urlToImage?.absoluteString
    }
    
    func fetchAllHeadlines() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.all()
        return (try? context.fetch(request)) ?? []
    }
    
    func predicateUrl(for url: String) -> NSPredicate {
        NSPredicate(format: "@K == %@", #keyPath(ArticleDB.urlDB), url )
    }
    
    
    
}



