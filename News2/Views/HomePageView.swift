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
//    @StateObject var articleManager = AllHeadlinesManager()
//    @StateObject var articleBase = ArticleDataBase()
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: ArticleDataBase.entity(), sortDescriptors: []) var fetchedResult: FetchedResults<ArticleDataBase>
    
//    @Environment (\.dismiss) private var dismiss
//    @ObservedObject var vm: ArticleDataViewModel
    
    var provider = CoreDataManager.shared
   @FetchRequest(fetchRequest: ArticleDB.all()) private var fetchedItems: FetchedResults<ArticleDB>
    @StateObject var vm = ArticleDataViewModel(provider: CoreDataManager.shared)
    //model
    @StateObject var viewModel = NewsViewModel()
    @State var article : Articles
    @State var searchText = ""
    @State var isPressed: Bool = true
    @State var viewActive = false
    let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    var body: some View {
       
        NavigationStack {
            //ScrollView{
                VStack(alignment: .leading){
                    Text("Discover things of this world")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Top Headlines")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                       ImageListView
                    Text("All Articles")
                        .font(.largeTitle)
                        .bold()
                    AllArticlesView
                }.navigationTitle("Browse")//.navigationBarTitleDisplayMode(.inline)
                    .padding(.all)
                    .background(
                    NavigationLink("", destination: BookmarksView(article: article), isActive: $viewActive))
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
                                viewActive = true
                            } label: {
                                Image(systemName: "bookmark")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                        }
                    }
            //}
            
        }.searchable(text: $searchText)
            .onChange(of: searchText) { articleTitle in
                viewModel.search(text: articleTitle)
            }
        
            
    }
    
    var AllArticlesView : some View {
        List(viewModel.searchArticles, id: \.publishedAt) { item in
           let cell = CellView(article: viewModel.getTitle(itemTitle: item.title))
            let details = DetailsView(article: viewModel.getArticle(articlePublishedAt: item.publishedAt))
            NavigationLink {
                details
            } label: {
                cell
            }
        }
    }
    
    var ImageListView: some View {
        
        ScrollView(.horizontal){
            HStack{
                ForEach(viewModel.topArticles, id: \.publishedAt) { item in
                    let articleURLtoImage = viewModel.getHeadlineURLtoImage(itemURLtoImage: item.urlToImage)
                    let destination = DetailsView(article: viewModel.getHeadline(headlinePublishedAt: item.publishedAt))
                    NavigationLink {
                        destination
                    } label: {
                        ImageView(articles: articleURLtoImage)
                    }
                }
            }
        }
                
            
            
        

//        List(viewModel.articles, id: \.publishedAt) { item in
//            let articleURLtoImage = viewModel.getURLtoImage(itemURLtoImage: item.urlToImage)
//            ImageView(articles: articleURLtoImage)
//            let cell = CellView(article: viewModel.getTitle(itemTitle: item.title))
//            let details = DetailsView(article: viewModel.getArticle(articlePublishedAt: item.publishedAt))
//            NavigationLink {
//                details
//            } label: {
//                cell
//            }
        
    }
    func addItem(){
        
        let newArticle = ArticleDB(context: provider.mainMOC)
       newArticle.id = UUID()
        newArticle.authorDB = article.author
        newArticle.titleDB = article.title
        newArticle.idSourceDB = article.source.id
        newArticle.nameSourceDB = article.source.name
        newArticle.descriptionDB = article.description
        newArticle.contentDB = article.content
        newArticle.publishedAtDB = article.publishedAt
        newArticle.urlDB = try? String(contentsOf: article.url)
        newArticle.urlToImageDB = try? String(contentsOf: article.urlToImage!)
       
        provider.loadStores()
        vm.saveContext()
        
   }
//   func removeItem(at offsets: IndexSet) {
//
//   }
//
   
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let  source = Source(id: nil, name: "Yahoo Entertainment")
        let item = Articles(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
        HomePageView( article: item)
        
    }
}
