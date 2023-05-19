//
//  HomePageView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI
import CoreData

struct HomePageView: View {
    
    @StateObject var viewModel = NewsViewModel()
    @State var searchText = ""
    @State var selection = 2
    @State var viewActive = false
    let backgroundColor = Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    Text("Discover things of this world")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Top Headlines")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    TopHeadlinesView
                    Text("All Articles")
                        .font(.largeTitle)
                        .bold()
                    AllArticlesView
                }
            }.navigationTitle("Browse")//.navigationBarTitleDisplayMode(.inline)
                .padding(.all)
        }.searchable(text: $searchText)
            .onChange(of: searchText) { articleTitle in
                viewModel.search(text: articleTitle)
            }
    }//end of HomePageView
    
    var TopHeadlinesView: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(viewModel.topArticles, id: \.self) { article in
                    NavigationLink {
                        DetailsView(article: article)
                    } label: {
                        ImageView(article: article)
                    }
                }
            }
        }
    }
    
    var AllArticlesView : some View {
        ForEach(viewModel.searchArticles, id: \.self) { article in
            let cell = CellView(article: article)
            let details = DetailsView(article: article)
            NavigationLink {
                details
            } label: {
                cell
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
        
    }
}
