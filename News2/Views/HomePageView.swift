//
//  HomePageView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI
import CoreData

struct HomePageView: View {
    //dataBase model
    // @Environment(\.managedObjectContext) var moc
   // @State var coreManager = CoreDataManager()
    
    //model
    @StateObject var viewModel = NewsViewModel()
    @State var searchText = ""
    @State var isPressed: Bool = true
    @State var viewActive = false
    let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
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
                .toolbar {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar) {
                        Button {
                            //what does it do?
                        } label: {
                            Image(systemName: "house.fill")
                                .foregroundColor(Color(backgroundColor))
                        }
                        Spacer()
                        Image(systemName: "square.split.2x2")
                            .foregroundColor(.gray)
                        Spacer()
                        Button {
                            BookmarksView()
                        } label: {
                            Image(systemName: "bookmark")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                    }
                }
        }.searchable(text: $searchText)
            .onChange(of: searchText) { articleTitle in
                //viewModel.search(text: articleTitle)
            }
    }
    
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
        ForEach(viewModel.articles, id: \.self) { article in
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
