//
//  mageList.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI
struct URLImageBookmarkView: View {
    let urlString: URL?
    @State var data: Data?
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .cornerRadius(20.0)
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .cornerRadius(20.0)
                .onAppear{
                    fetchData()
            }
        }
    }
    private func fetchData() {
        guard let url : URL = urlString else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
struct ImageView: View {
    @StateObject var favViewModel = FavoriteViewModel()
    @State var article: ArticleDB
    var bookmarkPressed: Bool = true
    var body: some View {
        ZStack{
            URLImageBookmarkView(urlString: article.urlToImage)
            VStack(alignment: .trailing){
                Button {
                    favViewModel.bookmarkArticle(article: article)
                } label: {
                    
                    checkBookmark
                }
                Text(article.titleDB ?? "")
                    .frame(width: 190.0, height: 80.0)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
    
    var checkBookmark: some View {
        Image(systemName: article.isFavorite ? "bookmark.fill" : "bookmark")
            .foregroundColor( .white)
            .frame(width: 10.0, height: 80.0, alignment: .topTrailing)
            .bold()
            .padding()
    }

        
}
//Data(contentsOf: ) do not use with network because it is sync and blocks the main thread, making the app slow down
// using URLSession.shared.dataTask instead, but doesn't work


