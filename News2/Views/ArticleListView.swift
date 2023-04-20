//
//  ArticleListView.swift
//  News2
//
//  Created by MacBook on 4/15/23.
//

import SwiftUI

struct ArticleListView: View {
    
    @StateObject var viewModel = NewsViewModel()
    @State var article: Articles
    var body: some View {
        List(viewModel.articles, id: \.publishedAt) { item in
           let cell = CellView(article: viewModel.getTitle(itemTitle: item.title))
            let details = DetailsView(article: viewModel.getArticle(articlePublishedAt: item.publishedAt))
            NavigationLink {
                details
            } label: {
                cell
            }
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        let  source = Source(id: nil, name: "Yahoo Entertainment")
        let item = Articles(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
        ArticleListView( article: item)
    }
}
