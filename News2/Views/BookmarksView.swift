//
//  BookmarksView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct BookmarksView: View {
    @StateObject var favViewModel = FavoriteViewModel()
    @State var viewActive = false
    let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    HStack {
                        Text("Saved articles to the library")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Spacer()
                    }.padding(.leading)
                    Spacer()
                    if favViewModel.bookmarks == [] {
                        NoSavedBookmarksView
                            .padding(.maximum(100.0, 10.0))
                    } else {
                        SavedBookmarksView
                    }
                }.navigationTitle("Bookmarks")
            }
        }
        .onAppear(){
            print("on appear")
            print(favViewModel.bookmarks.count)
            favViewModel.bookmarks = favViewModel.getAllFeaturedFavorites()
            print(favViewModel.bookmarks.count)
        }// end of navView
    }//end of body var
    
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
        ScrollView{
            ForEach(favViewModel.bookmarks) { item in
                let cell = CellView(article: item)
                let details = DetailsView(article: item)
                NavigationLink {
                    details
                } label: {
                    cell
                }
            }
        }.padding()
    }
}//end of BookmarksView




