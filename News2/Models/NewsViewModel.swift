//
//  NewsViewModel.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation
import SwiftUI
 class NewsViewModel: ObservableObject {
     //managed variables for storing data, searching data
    @Published var articles: [ArticleDB] = []
    @Published var topArticles: [ArticleDB] = []
    @Published var bookmarks: [ArticleDB] = []
    @Published var bookmark = ArticleDB()
    var allArticles = [ArticleDB]()
    @Published var searchArticles: [ArticleDB] = []
     //references
    var provider = CoreDataManager.shared
    var allHeadlinesManager : AllHeadlinesManager
    var topHeadlinesManager : TopHeadlinesManager
    
    
     init( topHeadlinesManager: TopHeadlinesManager = TopHeadlinesManager(), allHeadlinesManager: AllHeadlinesManager = AllHeadlinesManager()) {
        self.topHeadlinesManager = topHeadlinesManager
        self.allHeadlinesManager = allHeadlinesManager

         //isuess when pulling data from network for the first time, pulls at the same time? too fast so it chrashes
        //getTopHeadlines()
        getAllHeadlines()
         //getAllHeadlinesTest()
         
    }
    
     func getTopHeadlines() {
         topHeadlinesManager.getData { [weak self] success in
             guard let self else { return }
             DispatchQueue.main.async {
                 self.topArticles = self.topHeadlinesManager.fetchHeadlines()
             }
         }
     }
     
    func getAllHeadlines() {
        allHeadlinesManager.getData { [weak self] success in
            guard let self else {return}
            DispatchQueue.main.async {
                self.articles = self.allHeadlinesManager.fetchAllHeadlines()
                self.searchArticles = self.articles
                self.allArticles = self.articles
            }
        }
    }

     func getArticle(by url: String) -> ArticleDB? {
         topArticles.first(where:  { $0.urlDB == url })
     }
//to make a list of bookmarks in the BookmarksView
     func getAllFeaturedFavorites() -> [ArticleDB] {
         return allHeadlinesManager.fetchFavorites(context: provider.writeMOC)
     }

    
//called in BookmarksView
     func bookmarkArticle(article: ArticleDB) {
         bookmark = allHeadlinesManager.addBookmark(article: article, context: provider.writeMOC)
         bookmarks.append(bookmark)
     }
//called in ImageView
//     func bookmarkTopArticle() {
//         bookmark = topHeadlinesManager.findAndUpdate() ?? ArticleDB()
//     }
   
//functionality works fine, no issues
    func search(text: String)  {
        if text.isEmpty {
            searchArticles = allArticles
        } else {
            searchArticles = articles.filter({$0.titleDB?.contains(text) ?? true})
        }
    }
}//end of viewModel


