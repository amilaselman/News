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
        guard let url = URL(string: urlString) else { return} // check za kasnije
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let recievedData = data {
                do {
                    let items = try JSONDecoder().decode(News.self, from: recievedData)
                    for item in items.articles {
                        self.addItem(article: item)
                    }
                    DispatchQueue.main.async {
                        completionHandler(true)
                    }
                } catch {
                    completionHandler(false)
                }
            }
        }.resume()
    }
    
    func addItem(article: Article) {
        let context = coreManager.writeMOC
        let newArticle = ArticleDB(context: context)

        context.perform {
            //newArticle.id = UUID()
            newArticle.authorDB = article.author
            newArticle.titleDB = article.title
            newArticle.idSourceDB = article.source.id
            newArticle.nameSourceDB = article.source.name
            newArticle.descriptionDB = article.description
            newArticle.contentDB = article.content
            newArticle.publishedAtDB = article.publishedAt
            newArticle.urlDB = article.url.absoluteString
            newArticle.urlToImageDB = article.urlToImage?.absoluteString
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error {
                    print("Unable to save context: \(error)")
                }
            }
        }
    }
    
    func fetchHeadlines() -> [ArticleDB] {
        let context = coreManager.mainMOC
        let request = ArticleDB.all()
        return (try? context.fetch(request)) ?? []
    }
}


