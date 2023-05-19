//
//  News2App.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import SwiftUI


@main
struct News2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = NewsViewModel()
    @State var tabSelected = 0
    var body: some Scene {
        WindowGroup {
            let backgroundColor = Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
                TabView(selection: $tabSelected) {
                    HomePageView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }.tag(0)
                    CategoriesView()
                        .tabItem {
                            Image(systemName: "square.split.2x2")
                            Text("Categories")
                        }.tag(1)
                    BookmarksView()
                        .tabItem {
                            Image (systemName: "bookmark.fill")
                            Text("Bookmarks")
                        }.tag(2)
                        .onAppear(){
                            viewModel.getAllFeaturedFavorites()
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }.tag(3)
                }
                .accentColor(backgroundColor)
                
            
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

