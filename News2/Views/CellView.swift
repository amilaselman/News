//
//  CellView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct URLImage: View {
    let urlString: URL?
    @State var data: Data?
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
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


struct CellView: View {
    @State var article: ArticleDB
    var body: some View {
        HStack {
            URLImage(urlString: article.urlToImage)
                .scaledToFill()
                .frame(width: 100, height: 100).cornerRadius(10.0)
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text(article.nameSourceDB ?? "")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.bottom, 3)
                Text(article.titleDB ?? "")
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        let  source = Source(id: nil, name: "Yahoo Entertainment")
//        let item = Article(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
//       
//    }
//}
