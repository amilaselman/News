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
            self.data = data
        }.resume()
    }
}
struct ImageView: View {
    @StateObject var viewModel = NewsViewModel()
    @State var article: ArticleDB
    var bookmarkPressed: Bool = true
    var body: some View {
        ZStack{
            URLImageBookmarkView(urlString: article.urlToImage)
            VStack(alignment: .trailing){
                Button {
                    article.isFavorite.toggle()
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
//    func buttonPressed ()  {
//        viewModel.bookmarkTopArticle()
//    }
    //        func bookmarkedArticle(by url: String) {
    //            let article = viewModel.getArticle(by: url)
    //            if let article = article {
    //                article.isFavorite = true
    //            } else {
    //                article?.isFavorite = false
    //            }
    //        }
    
}
//Data(contentsOf: ) do not use with network because it is sync and blocks the main thread, making the app slow down
// using URLSession.shared.dataTask instead, but doesn't work

extension Image {
//    func data(url: URL) -> Self {
//
//        if let data = try? Data(contentsOf: url) {
//            return Image(uiImage: UIImage(data: data)!)
//                .resizable()
//        }
//        return self
//            .resizable()
//    }
    func data(url: URL) -> Self {
           guard let data = try? Data(contentsOf: url),
                 let uiImage = UIImage(data: data)
           else {
               return self
                   .resizable()
           }
           return Image(uiImage: uiImage)
               .resizable()
       }
    
//    func imageFromUrl(url: URL) -> Image {
//        let urlRequest = URLRequest(url: url)
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data,
//                      let uiImage = UIImage(data: data) else {return}
//              return  Image(uiImage: uiImage)
//            }
//        }.resume()
//        return self
//    }

}
