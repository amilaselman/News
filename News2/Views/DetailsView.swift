//
//  DetailsView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel = NewsViewModel()
    @StateObject var favViewModel = FavoriteViewModel()
    @State var article : ArticleDB
    @State var viewActive = false
    let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    let fontColor = CGColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    var body: some View {
        NavigationView {
            viewContent
                .navigationTitle("")
                .padding(.all, 10)
                .toolbar {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        ShareLink(item: article.urlDB ?? String()){
                            Image(systemName: "arrowshape.turn.up.right")
                                .foregroundColor(.gray)
                        }
                        Button {
                            favViewModel.bookmarkArticle(article: article)
                        } label:{
                            Image(systemName: article.isFavorite ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.gray)
                    }
                }
            }
        }.onAppear(){
            favViewModel.onAppearBookmarks()
        }
    }
    var viewContent: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Image(systemName: "photo")
                    .imageFromUrl(url: article.urlToImage ?? URL(fileURLWithPath: ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350.0, height: 150.0)
                    .cornerRadius(20.0)
                    .padding(.all)
                Spacer()
                Text(article.nameSourceDB ?? String())
                    .foregroundColor(.white)
                    .font(.caption)
                    .bold()
                    .frame(width: 100, height: 40)
                    .background(Color(backgroundColor)).cornerRadius(15.0)
                Text(article.titleDB ?? String())
                    .font(.system(size: 30))
                    .lineLimit(9)
                    .bold()
                Spacer()
                Text(article.authorDB ?? "")
                    .font(.title2)
                Spacer()
                Text("Results")
                    .font(.title3)
                    .fontWeight(.bold)
                if let url = article.url {
                    Link(destination: url) {
                        Text(article.contentDB ?? "")
                            .foregroundColor(Color(fontColor))
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                            .padding(10)
                    }
                }
            }
        }
    }
}

extension Image {
//    func data(url: URL) -> Self {
//           guard let data = try? Data(contentsOf: url),
//                 let uiImage = UIImage(data: data)
//           else {
//               return self
//                   .resizable()
//           }
//           return Image(uiImage: uiImage)
//               .resizable()
//       }
    

    func imageFromUrl(url: URL) -> Self {
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let uiImage = UIImage(data: data) else {return}
                return uiImage
            }
        }.resume()
    }
}




