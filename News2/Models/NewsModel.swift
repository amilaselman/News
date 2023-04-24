//
//  TopHeadlinesModel.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import Foundation

struct News: Codable, Hashable {
    
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Source: Codable, Hashable, Identifiable {
    var id: String?
    var name: String
}

struct Article: Codable, Hashable {
   // let id: UUID//
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: URL
    var urlToImage: URL?
    var publishedAt: String
    var content: String?
}



//
// example of TopHeadlinesModel
//
//"status": "ok",
//"totalResults": 35,
//"articles": [
//{
//"source": {
//"id": null,
//"name": "Yahoo Entertainment"
//},
//"author": "Ryan Young",
//"title": "Masters 2023 live: Follow Brooks Koepka, Jon Rahm and others as they battle for the green jacket - Yahoo Sports",
//"description": "The final round of the Masters is underway.",
//"url": "https://sports.yahoo.com/masters-2023-live-follow-brooks-koepka-jon-rahm-and-others-as-they-battle-for-the-green-jacket-110042679.html",
//"urlToImage": "https://s.yimg.com/ny/api/res/1.2/n47WshrwZ4Q8wEYd.A8ViA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2023-03/1dd31de0-d6f5-11ed-bdff-8bf5c17e3329",
//"publishedAt": "2023-04-09T20:29:35Z",
//"content": "Jon Rahm (left) and Brooks Koepka are going head-to-head in the final round of the 2023 Masters. Will one of them walk away with the green jacket? (Photo by Andrew Redington/Getty Images) The final … [+472 chars]"
//},
