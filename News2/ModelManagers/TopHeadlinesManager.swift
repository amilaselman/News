//
//  TopHeadlinesManager.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

//https://newsapi.org/v2/top-headlines?country=us&apiKey=9044fe8605c447b587a2adc404452dd5#
import Foundation

class TopHeadlinesManager  {
    //my function
    func getData(completionHandler: @escaping (News) -> ()) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9044fe8605c447b587a2adc404452dd5#"
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


