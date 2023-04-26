//
//  BookmarksView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct BookmarksView: View {
    //@StateObject var viewModel = NewsViewModel()
    //@State var article: ArticleDB
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
                //                if viewModel.bookmarks == [] {
                NoSavedBookmarksView
                    .padding(.maximum(100.0, 10.0))
                //                } else {
                //                   // SavedBookmarksView
                //                }
            }.navigationTitle("Bookmarks")
                .background(
                    NavigationLink("", destination: HomePageView(), isActive: $viewActive)
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
    
    //    var SavedBookmarksView: some View {
    //
    //        List(article, id: \.self) { item in
    //            CellView(article: item)
    //
    //            }
    //        }
}




