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
    
    var body: some Scene {
        WindowGroup {
        //start screen -> SplashScreen() 0.5 sec then
                        //HomepageView() :
                                        //BookmarksView() -> saved articles from dataBase
                                        //DetailsView() -> any article detailed description
            SplashScreen()
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

