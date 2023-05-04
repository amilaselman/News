//
//  NewsViewModel.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation
import SwiftUI
 class NewsViewModel: ObservableObject {
    @Published var articles: [ArticleDB] = []
    @Published var topArticles: [ArticleDB] = []
    //@Published var savedArticles = [ArticleDB]()
    @Published var bookmarks: [ArticleDB] = []
    var allArticles = [ArticleDB]()
    @Published var searchArticles: [ArticleDB] = []
    
    var provider = CoreDataManager.shared
    var allHeadlinesManager : AllHeadlinesManager
    var topHeadlinesManager : TopHeadlinesManager
    
    init( topHeadlinesManager: TopHeadlinesManager = TopHeadlinesManager(), allHeadlinesManager: AllHeadlinesManager = AllHeadlinesManager()) {
        self.topHeadlinesManager = topHeadlinesManager
        self.allHeadlinesManager = allHeadlinesManager
        getTopHeadlines()
        getAllHeadlines()
    }
    
     
     func getTopHeadlines() {
         topHeadlinesManager.getData { [weak self] success in
             guard let self else { return }
             DispatchQueue.main.async {
                 self.topArticles = self.topHeadlinesManager.fetchHeadlines()
                 //self.bookmarks = self.topHeadlinesManager.fetchHeadlines()
             }
         }
     }
     
    func getAllHeadlines() {
        allHeadlinesManager.getData { [weak self] success in
            guard let self else {return}
            DispatchQueue.main.async {
                self.searchArticles = self.allHeadlinesManager.fetchAllHeadlines()
                self.articles = self.allHeadlinesManager.fetchAllHeadlines()
                self.allArticles = self.allHeadlinesManager.fetchAllHeadlines()
            }
        }
    }
     
     func getArticle(by url: String) -> ArticleDB? {
         topArticles.first(where:  { $0.urlDB == url })
     }

     func getAllFeaturedFavorites () -> [ArticleDB] {
         return allHeadlinesManager.fetchFavorites()
      
     }

    func addBookmark(article: ArticleDB) {
        bookmarks.insert(article, at: 0)
    }

    func search(text: String)  {
        if text.isEmpty {
            searchArticles = allArticles
        } else {
            searchArticles = articles.filter({$0.titleDB!.contains(text)})
        }
    }
}//end of viewModel

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
           return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
