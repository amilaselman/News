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
    @Published var savedArticles = [ArticleDB]()
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
    
    
    func getArticle(by url: String) -> ArticleDB? {
        topArticles.first(where:  { $0.urlDB == url })
    }
    
    
    func getAllHeadlines() {
        allHeadlinesManager.getData { [weak self] success in
            guard let self else {return}
//            self.articles = news.articles
//            //self.bookmarks = news.articles
//            self.savedArticles = news.articles
            DispatchQueue.main.async {
                self.articles = self.allHeadlinesManager.fetchAllHeadlines()
                self.searchArticles = self.allHeadlinesManager.fetchAllHeadlines()
                self.allArticles = self.allHeadlinesManager.fetchAllHeadlines()
            }
           
        }
    }
    func getTopHeadlines() {
        topHeadlinesManager.getData { [weak self] success in
            guard let self else { return }
            DispatchQueue.main.async {
                self.topArticles = self.topHeadlinesManager.fetchHeadlines()

            }
            //self.bookmarks = self.topHeadlinesManager.fetchHeadlines()

        }
    }
    
    
    // everything headlines
    func getArticle(articlePublishedAt: String) -> ArticleDB {
        articles.first(where: {$0.publishedAtDB == articlePublishedAt})!
    }

//    func isBookmarkPressed(article: ArticleDB) -> Bool {
//        bookmarks.first(where: {article.publishedAtDB == $0.publishedAtDB}) != nil
//    }
//
//    func addBookmark(article: ArticleDB) {
//        guard !isBookmarkPressed(article: article) else { return }
//        bookmarks.insert(article, at: 0)
//    }
//    func removeBookmark(article: ArticleDB) {
//        //obrnuto
//        guard let index = bookmarks.firstIndex(where: {$0.publishedAtDB == article.publishedAtDB}) else { return }
//        bookmarks.remove(at: index)
//    }
//    func saveArticleToBookmark(article : ArticleDB) {
//        if isBookmarkPressed(article: article) {
//            removeBookmark(article: article)
//        } else {
//            addBookmark(article: article)
//
//        }
//    }
//
    func search(text: String)  {
        if text.isEmpty {
            searchArticles = allArticles
        } else {
            searchArticles = articles.filter({$0.titleDB!.contains(text)})
        }
    }
    
//    func getBookmark(publishedAt: String ) -> Article {
//        bookmarks.first(where: {$0.publishedAt == publishedAt})!
//    }
//    func getBookmarkTitle(bookmarkTitle: String) -> Article {
//        bookmarks.first(where: {$0.title == bookmarkTitle})!
//    }
//
    
}
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
