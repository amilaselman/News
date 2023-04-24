//
//  NewsViewModel.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation
import SwiftUI
class NewsViewModel: ObservableObject {
    @Published var articles = [Articles]()
    @Published var topArticles = [Articles]()
    @Published var savedArticles = [Articles]()
    @Published var bookmarks: [Articles] = []
    
    
    //@StateObject var vm = ArticleDataViewModel(provider: CoreDataManager.shared)
    //@FetchRequest(fetchRequest: ArticleDataBase.all()) private var fetchedItems: FetchedResults<ArticleDataBase>
    var provider = CoreDataManager.shared
    
    
    var allArticles = [Articles]()
    @Published var searchArticles: [Articles] = []
    //var allArticles = [Articles]()
    //@Published var savedArticlesDB = [ArticleDataBase]()
    //@Published var bookmarksDB: [ArticleDataBase] = []
    var allHeadlinesManager : AllHeadlinesManager
    var topHeadlinesManager : TopHeadlinesManager
    
    
    init( topHeadlinesManager: TopHeadlinesManager = TopHeadlinesManager(), allHeadlinesManager: AllHeadlinesManager = AllHeadlinesManager()) {
        self.topHeadlinesManager = topHeadlinesManager
        self.allHeadlinesManager = allHeadlinesManager
        getTopHeadlines()
        getAllHeadlines()
        
    }
    
    func getAllHeadlines() {
        allHeadlinesManager.getData { news in
            self.articles = news.articles
            //self.bookmarks = news.articles
            self.savedArticles = news.articles
            self.searchArticles = news.articles
            self.allArticles = news.articles
        }
    }
    func getTopHeadlines() {
        topHeadlinesManager.getData { news in
            self.topArticles = news.articles
            self.bookmarks = self.allArticles
            self.savedArticles = news.articles
        }
    }
    
    
    // everything headlines
    func getArticle(articlePublishedAt: String) -> Articles {
        articles.first(where: {$0.publishedAt == articlePublishedAt})!
    }
    //source
    func getAuthor(itemAuthor: String?) -> Articles {
        articles.first(where: {$0.author == itemAuthor})!
    }
    func getTitle(itemTitle: String) -> Articles {
        articles.first(where: {$0.title == itemTitle })!
//        guard let article = articles.first(where: {$0.title == itemTitle }) else{return print("error")}
//            return article
    }
    func getDescription(itemDescription: String?) -> Articles {
        articles.first(where: {$0.description == itemDescription})!
    }
    func getURL(itemURL: URL) -> Articles {
        articles.first(where: {$0.url == itemURL})!
    }
    func getURLtoImage(itemURLtoImage: URL?) -> Articles {
        articles.first(where: {$0.urlToImage == itemURLtoImage})!
    }
    func getContent(itemContent: String) -> Articles {
        articles.first(where: {$0.content == itemContent})!
    }
    
   
    
    //description
    //top headlines
    func getHeadline(headlinePublishedAt: String) -> Articles {
        topArticles.first(where: {$0.publishedAt == headlinePublishedAt})!
    }
    func getHeadlineAuthor(itemAuthor: String?) -> Articles {
        topArticles.first(where: {$0.author == itemAuthor})!
    }
    func getHeadlineTitle(itemTitle: String) -> Articles {
        topArticles.first(where: {$0.title == itemTitle })!
//        guard let article = articles.first(where: {$0.title == itemTitle }) else{return print("error")}
//            return article
    }
    func getHeadlineDescription(itemDescription: String?) -> Articles {
        topArticles.first(where: {$0.description == itemDescription})!
    }
    
    func getHeadlineURL(itemURL: URL) -> Articles {
        topArticles.first(where: {$0.url == itemURL})!
    }
    func getHeadlineURLtoImage(itemURLtoImage: URL?) -> Articles {
        topArticles.first(where: {$0.urlToImage == itemURLtoImage})!
    }
    func getHeadlineContent(itemContent: String) -> Articles {
        topArticles.first(where: {$0.content == itemContent})!
    }
    
    func isBookmarkPressed(article: Articles) -> Bool {
        bookmarks.first(where: {article.publishedAt == $0.publishedAt}) != nil
    }
    
    func addBookmark(article: Articles) {
        if isBookmarkPressed(article: article) != nil {
            bookmarks.insert(article, at: 0)
        } else {
            return
        }
//        guard !isBookmarkPressed(article: article) else { return }
//        bookmarks.insert(article, at: 0)
    }
    func removeBookmark(article: Articles) {
        //obrnuto
        guard let index = bookmarks.firstIndex(where: {$0.publishedAt == article.publishedAt}) else { return }
        bookmarks.remove(at: index)
    }
    func saveArticleToBookmark(article : Articles) {
        if isBookmarkPressed(article: article) {
            removeBookmark(article: article)
        } else {
            addBookmark(article: article)
            //provider.loadStores()
        }
    }
   
    func search(text: String)  {
        if text.isEmpty {
            searchArticles = allArticles
        } else {
            searchArticles = articles.filter({$0.title.contains(text)})
        }
    }
    
    func getBookmark(publishedAt: String ) -> Articles {
        bookmarks.first(where: {$0.publishedAt == publishedAt})!
    }
    func getBookmarkTitle(bookmarkTitle: String) -> Articles {
        bookmarks.first(where: {$0.title == bookmarkTitle})!
    }
    
//    func saveArticle(publishedAt: String) {
//        var newArticleList = savedArticles
//        let newElement = savedArticles.first(where: {$0.publishedAt == publishedAt})
//        newArticleList.append(newElement!)
//
//    }

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
