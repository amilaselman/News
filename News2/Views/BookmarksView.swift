//
//  BookmarksView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct BookmarksView: View {
    
   // var provider = CoreDataManager.shared
    //@FetchRequest(fetchRequest: ArticleDB.all()) private var fetchedItems: FetchedResults<ArticleDB>
    //@StateObject var vm = ArticleDataViewModel(provider: CoreDataManager.shared)
    
    @StateObject var viewModel = NewsViewModel()
    @State var article: Articles
    @State var viewActive = false
    let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Saved articles to the library")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Spacer()
                }.padding(.leading)
                Spacer()
                if viewModel.bookmarks == [] {
                    NoSavedBookmarksView
                        .padding(.maximum(100.0, 10.0))
                } else {
                    SavedBookmarksView
                    
                }
            }.navigationTitle("Bookmarks")
                .background(
                    NavigationLink("", destination: HomePageView(article: article), isActive: $viewActive)
                )
                .toolbar {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar) {
                        Button {
                            viewActive = true
                        } label: {
                            Image(systemName: "house")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "square.split.2x2")
                            .foregroundColor(.gray)
                        Spacer()
                        Button {
                            //goToBookmarks()
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(Color(backgroundColor))
                        }
                        Spacer()
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                    }
                }
        }
    }
    
    var NoSavedBookmarksView : some View {
        VStack{
            ZStack {
                Circle().frame(width: 70, height: 70)
                    .foregroundColor(.gray).opacity(0.2)
                Image(systemName: "book.closed")
                    .foregroundColor(Color(backgroundColor))
            }
            Text("You haven't saved any articles yet. \n Start reading and bookmarking them now.")
                .lineLimit(4)
                .multilineTextAlignment(.center)
        }
    }
    
    var SavedBookmarksView: some View {
    
        HStack {
            List(viewModel.bookmarks, id: \.publishedAt) { item in
                CellView(article: viewModel.getBookmark(publishedAt: item.publishedAt))
                
            }
            
        }
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        let  source = Source(id: nil, name: "Yahoo Entertainment")
        let item = Articles(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
        BookmarksView(article: item)
    }
}


