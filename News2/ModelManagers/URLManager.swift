//
//  URLManager.swift
//  News2
//
//  Created by MacBook on 5/23/23.
//

import Foundation

extension TopHeadlinesManager {
    func generateTopApi (language: String, country: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: "9044fe8605c447b587a2adc404452dd5#")
        let countryQueryItem = URLQueryItem(name: "country", value: country)
        let languageQueryItem = URLQueryItem(name: "language", value: language)
        components.queryItems = [apiKeyQueryItem, countryQueryItem, languageQueryItem]

        return components.url
    }
}
//GET https://newsapi.org/v2/everything?q=Apple&from=2023-05-24&sortBy=popularity&apiKey=API_KEY

extension AllHeadlinesManager {
    func generateApi (language: String, country: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: "9044fe8605c447b587a2adc404452dd5#")
        let countryQueryItem = URLQueryItem(name: "country", value: country)
        let languageQueryItem = URLQueryItem(name: "language", value: language)
        components.queryItems = [apiKeyQueryItem, countryQueryItem, languageQueryItem]

        return components.url
    }
}

enum Category {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

enum Country {
    case us
    case ae
    case ca
    case gb
    case hu
    case it
}
enum Language {
    case ar
    case de
    case en
    case es
    case fr
    case he
    case it
    case nl
    case ud
}

