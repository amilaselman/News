//
//  FavoriteViewModel.swift
//  News2
//
//  Created by MacBook on 5/22/23.
//

import Foundation
import SwiftUI
class FavoriteViewModel: ObservableObject {
    @Published var bookmarks : [ArticleDB] = []
    var allHeadlinesManager : AllHeadlinesManager
    var topHeadlinesManager : TopHeadlinesManager
    var provider = CoreDataManager.shared
    
    init(allHeadlinesManager: AllHeadlinesManager = AllHeadlinesManager(), topHeadlinesManager: TopHeadlinesManager = TopHeadlinesManager()) {
        self.allHeadlinesManager = allHeadlinesManager
        self.topHeadlinesManager = topHeadlinesManager
    }
    //to make a list of bookmarks in the BookmarksView
    func onAppearBookmarks() {
        bookmarks = getAllFeaturedFavorites()
    }
    func getAllFeaturedFavorites() -> [ArticleDB] {
        return allHeadlinesManager.fetchFavorites(context: provider.mainMOC)
    }
    //called in BookmarksView
    //adds bookmark to BookmarkView, and shows in a list when getAllFeaturedFavorites() is called in onAppear() block
    func bookmarkArticle(article: ArticleDB) {
        allHeadlinesManager.addOrRemoveBookmark(by: article.urlDB ?? String(), context: provider.writeMOC)
    }

}//end of FavoriteViewModel
