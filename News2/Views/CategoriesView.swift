//
//  CategoriesView.swift
//  News2
//
//  Created by MacBook on 5/17/23.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel = NewsViewModel()
    let backgroundColor = Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
    let fontColor = Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    var body: some View {
        NavigationStack{
            CategoryButtonsView
            Spacer()
            ListView
                .navigationTitle("Choose from category")//change the size of title
        }.onAppear(){
            viewModel.onAppearAllHeadlines()
        }
 }
    var CategoryButtonsView: some View {
        ScrollView(.horizontal){
            HStack{
                Button {
                    //viewModel.getGeneralArticles()
                } label: {
                    Text("General")
                        .frame(width: 100, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    //viewModel.getSportsArticles()
                } label: {
                   Text("Sports")
                        .frame(width: 80, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    //viewModel.getBusinessArticles()
                } label: {
                    Text("Business")
                        .frame(width: 100, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    //viewModel.getFinanceArticles()
                } label: {
                    Text("Finance")
                        .frame(width: 100, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    //viewModel.getScienceArticles()
                } label: {
                    Text("Science")
                        .frame(width: 100, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    
                } label: {
                    Text("Technology")
                        .frame(width: 120, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    
                } label: {
                    Text("Entertainment")
                        .frame(width: 150, height: 40)
                        .background(backgroundColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .minimumScaleFactor(0.5)
                }
            }.padding(.all)
        }
    }
    
    
    var ListView: some View {
            List (viewModel.allArticles){ article in
                let cell = CellView(article: article)
                let details = DetailsView(article: article)
                NavigationLink {
                    details
                } label: {
                    cell
                }
            }
//            .refreshable {
//                viewModel.getNewHeadlines()
//            }
       
    }
    
    func CategoryView(category: String) -> any View {
        HStack{
            Text("\(category)")
                .frame(width: 100, height: 40)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(10)
            
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
