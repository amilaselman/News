//
//  ContentView.swift
//  News2
//
//  Created by MacBook on 4/11/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    var body: some View {
        let backgroundColor = CGColor(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.9486688273))
        NavigationView {
            ZStack{
                if self.isActive {
                    HomePageView()
                } else {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    Image(systemName: "circle")
                        .foregroundColor(.blue)
                    Image("logo")
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
