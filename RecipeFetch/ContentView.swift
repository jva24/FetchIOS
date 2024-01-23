//
//  ContentView.swift
//  RecipeFetchOS
//
//  Created by Meto Ajagu on 12/7/23.
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit
import SDWebImage

struct ContentView: View {
    @State private var recipe: String = ""
    @State private var area: String = ""
    @State private var ingredient: String = ""
    @State private var category: String = ""
    
    @State private var activeFilter: FilterType?
    @StateObject var networking = NetworkingManager()
    
    enum FilterType {
        case recipe, area, ingredient, category
    }
    
    init (){
        print("ContentView Initialized")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
        
                Text("Click A Recipe:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                
                ScrollView(.vertical) {
                    ForEach(networking.recipes, id: \.idMeal) { recipe in
                        NavigationLink (
                            destination: DetailedRecipeView(idMeal: recipe.idMeal), label: {
                                    LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                        Text(recipe.strMeal)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                        WebImage(url: URL(string: recipe.strMealThumb))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    }
                                
                        })
                    }
                    .onAppear(perform: {
                        networking.fetchDessertData()
                    })
                }
                .padding()
            }
                
        }
    }
}
    
#Preview {
   RecipeHome()
}
