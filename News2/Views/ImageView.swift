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
    @State var article: ArticleDB
    var bookmarkPressed: Bool = true
    var body: some View {
        ZStack{
                URLImageBookmarkView(urlString: article.urlToImage)
            VStack(alignment: .trailing){
                Button {
                    //viewModel.saveArticleToBookmark(article: articles)
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
        Image(systemName: "bookmark")
            .foregroundColor( .white)
            .frame(width: 10.0, height: 80.0, alignment: .topTrailing)
            .bold()
            .padding()
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        let source = Source(id: nil, name: "Yahoo Entertainment")
//        let item = Article(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
//
//        let source2 = Source(id: "the-verge",name: "The Verge")
//        let item2 = Article(source: source2, author: "Elizabeth Lopatto" ,  title: "Connor Roy is the real heart of Succession - The Verge", description: "Connor Roy, played impeccably by Alan Ruck, is the key to understanding the show. Without Connor, the way the other siblings compete doesn’t make sense.",  url: URL(string: "https://www.theverge.com/2023/4/11/23679320/succession-connor-roy-alan-ruck")! , urlToImage: URL(string: "https://cdn.vox-cdn.com/thumbor/rns1LO5wB5Y0CR0gf-3e9Wk2sR0=/0x0:1920x1280/1200x628/filters:focal(960x640:961x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/24578694/alan_ruck_0.jpg") , publishedAt: "2023-04-11T21:25:38Z", content: "Connor Roy is the real heart of Succession Connor Roy is the real heart of Succession / Im ready for the Alan Ruckaissance. The key to Succession has been staring you in the face for four seasons… [+4502 chars]")
//
//    }
//}
//
