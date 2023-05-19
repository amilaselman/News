//
//  CellView.swift
//  News2
//
//  Created by MacBook on 4/12/23.
//

import SwiftUI

struct URLImage: View {
    let urlString: URL?
    @State var data: Data?
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
                .onAppear{
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url : URL = urlString else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.data = data
        }.resume()
    }
}


struct CellView: View {
    @State var article: ArticleDB
    var body: some View {
        HStack {
            URLImage(urlString: article.urlToImage)
                .scaledToFill()
                .frame(width: 100, height: 100).cornerRadius(10.0)
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text(article.nameSourceDB ?? "")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.bottom, 3)
                Text(article.titleDB ?? "")
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
