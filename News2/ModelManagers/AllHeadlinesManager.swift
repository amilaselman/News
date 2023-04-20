//
//  AllHeadlinesManager.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation
import CoreData
//https://newsapi.org/v2/everything?q=apple&apiKey=API
//set enum cases for q
// api key 
class AllHeadlinesManager{
//     NSObject, ObservableObject
//        @Published var articleData: ArticleDataBase = ArticleDataBase()
//        let container: NSPersistentContainer = NSPersistentContainer(name: "ArticleDataModel")
//    override init() {
//        super.init()
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error as NSError? {
//                fatalError("Container load failed: \(error)")
//            }
//        }
//    }
//
   
    
    func getData(completionHandler: @escaping (News) -> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=9044fe8605c447b587a2adc404452dd5"
        guard let url = URL(string: urlString) else { return} // check za kasnije
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let recievedData = data {
                do {
                     let decodedData = try JSONDecoder().decode(News.self, from: recievedData)
                    DispatchQueue.main.async {
                       completionHandler(decodedData)
                    }
                } catch {
                    print(error)
                }
            }
                    
        }.resume()
    }
}



