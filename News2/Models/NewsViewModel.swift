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
    var allArticles = [ArticleDB]()
    @Published var searchArticles: [ArticleDB] = []
    //references
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
                self.topArticles = self.topHeadlinesManager.fetchTopHeadlines()
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
    func onAppearAllHeadlines() {
        allArticles  = allHeadlines()
    }
    func allHeadlines() -> [ArticleDB] {
       return allHeadlinesManager.fetchAllHeadlines()
    }
    func getArticle(by url: String) -> ArticleDB? {
        topArticles.first(where:  { $0.urlDB == url })
    }
    //functionality works fine
    func search(text: String)  {
        if text.isEmpty {
            searchArticles = allArticles
        } else {
            searchArticles = articles.filter({$0.titleDB?.contains(text) ?? true})
        }
    }
}//end of viewModel


