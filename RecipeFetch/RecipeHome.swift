//
//  RecipeHome.swift
//  RecipeFetchOS
//
//  Created by Meto Ajagu on 12/27/23.
//


import SwiftUI
import SDWebImageSwiftUI

struct RecipeHome: View {
    var body: some View {
        HStack{
            Text("RecipeFetch")
            WebImage(url: URL(string: "https://clipart-library.com/images/yTka86nLc.jpg"))
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        VStack {
            NavigationStack {
                Spacer()
                NavigationLink {
                    ContentView()
                }  label: {
                    VStack{
                        WebImage(url: URL(string: "https://clipart-library.com/images/yTka86nLc.jpg"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)))
                        homeButton
                    }
                }
                Spacer(minLength: 350)
            }
        }
        Text("Developed By Meto Ajagu")
    }
    
    private var homeButton: some View {
        Text("Welcome to RecipeFetch")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(Color(UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)))
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
            .clipShape(RoundedRectangle(cornerRadius: 35))
    }
}

#Preview {
    RecipeHome()
}
