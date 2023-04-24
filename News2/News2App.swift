//
//  News2App.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import SwiftUI


@main
struct News2App: App {
    @StateObject var viewModel : NewsViewModel = NewsViewModel()
    @StateObject var articleBase: ArticleDB = ArticleDB()
    var provider = CoreDataManager.shared
    
    
    var body: some Scene {
        WindowGroup {
            let  source = Source(id: nil, name: "Yahoo Entertainment")
            let item = Articles(source: source, author: "Ryan Young", title: "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports", description:"The final round of the Masters is underway." , url: URL(string: "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html")! , urlToImage: URL(string: "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329") , publishedAt: "2023-04-09T20:29:35Z", content: "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]")
        //start screen -> SplashScreen() 0.5 sec then
                        //HomepageView() :
                                        //BookmarksView() -> saved articles from dataBase
                                        //DetailsView() -> any article detailed description
            SplashScreen(article: item)
                .environment(\.managedObjectContext, provider.persistentContainer.viewContext)
            //just for testing
            //HomePageView(article: item)
                //.environment(\.managedObjectContext, ArticleProvider.shared.viewContext)
                //.environment(\.managedObjectContext, CoreDataManager.shared.mainMOC)
            //just for testing, errors when called on the main thread
           // DetailsView(article: item)
            // .environment(\.managedObjectContext, ArticleProvider.shared.viewContext)
        }
    }
}

