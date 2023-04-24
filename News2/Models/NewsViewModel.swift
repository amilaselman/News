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
    @Published var savedArticles = [Article]()
    @Published var bookmarks: [Article] = []
    var allArticles = [Article]()
    @Published var searchArticles: [Article] = []
    
   
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
            self.articles = self.allHeadlinesManager.fetchAllHeadlines()
//            self.articles = news.articles
//            //self.bookmarks = news.articles
//            self.savedArticles = news.articles
//            self.searchArticles = news.articles
//            self.allArticles = news.articles
        }
    }
    func getTopHeadlines() {
        topHeadlinesManager.getData { [weak self] success in
            guard let self else { return }
            self.topArticles = self.topHeadlinesManager.fetchHeadlines()
        }
    }
    
    
    // everything headlines
    func getArticle(articlePublishedAt: String) -> ArticleDB {
        articles.first(where: {$0.publishedAtDB == articlePublishedAt})!
    }
//
//    func getAuthor(itemAuthor: String?) -> Article {
//        articles.first(where: {$0.author == itemAuthor})!
//    }
//    func getTitle(itemTitle: String) -> Article {
//        articles.first(where: {$0.title == itemTitle })!
////        guard let article = articles.first(where: {$0.title == itemTitle }) else { return print("error") }
////            return article
//    }
//    func getDescription(itemDescription: String?) -> Article {
//        articles.first(where: {$0.description == itemDescription})!
//    }
//    func getURL(itemURL: URL) -> Article {
//        articles.first(where: {$0.url == itemURL})!
//    }
//    func getURLtoImage(itemURLtoImage: URL?) -> Article {
//        articles.first(where: {$0.urlToImage == itemURLtoImage})!
//    }
//    func getContent(itemContent: String) -> Article {
//        articles.first(where: {$0.content == itemContent})!
//    }
//
//
    
    //description
    //top headlines
//    func getHeadline(headlinePublishedAt: String) -> Article {
//        topArticles.first(where: {$0.publishedAt == headlinePublishedAt})!
//    }
//    func getHeadlineAuthor(itemAuthor: String?) -> Article {
//        topArticles.first(where: {$0.author == itemAuthor})!
//    }
//    func getHeadlineTitle(itemTitle: String) -> Article {
//        topArticles.first(where: {$0.title == itemTitle })!
////        guard let article = articles.first(where: {$0.title == itemTitle }) else{return print("error")}
////            return article
//    }
//    func getHeadlineDescription(itemDescription: String?) -> Article {
//        topArticles.first(where: {$0.description == itemDescription})!
//    }
//
//    func getHeadlineURL(itemURL: URL) -> Article {
//        topArticles.first(where: {$0.url == itemURL})!
//    }
//    func getHeadlineURLtoImage(itemURLtoImage: URL?) -> Article {
//        topArticles.first(where: {$0.urlToImage == itemURLtoImage})!
//    }
//    func getHeadlineContent(itemContent: String) -> Article {
//        topArticles.first(where: {$0.content == itemContent})!
//    }
//
//    func isBookmarkPressed(article: Article) -> Bool {
//        bookmarks.first(where: {article.publishedAt == $0.publishedAt}) != nil
//    }
//
//    func addBookmark(article: Article) {
////        if isBookmarkPressed(article: article) != nil {
////            bookmarks.insert(article, at: 0)
////        } else {
////            return
////        }
//        guard !isBookmarkPressed(article: article) else { return }
//        bookmarks.insert(article, at: 0)
//    }
//    func removeBookmark(article: Article) {
//        //obrnuto
//        guard let index = bookmarks.firstIndex(where: {$0.publishedAt == article.publishedAt}) else { return }
//        bookmarks.remove(at: index)
//    }
//    func saveArticleToBookmark(article : Article) {
//        if isBookmarkPressed(article: article) {
//            removeBookmark(article: article)
//        } else {
//            addBookmark(article: article)
//            //provider.loadStores()
//        }
//    }
//   
//    func search(text: String)  {
//        if text.isEmpty {
//            searchArticles = allArticles
//        } else {
//            searchArticles = articles.filter({$0.title.contains(text)})
//        }
//    }
    
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
