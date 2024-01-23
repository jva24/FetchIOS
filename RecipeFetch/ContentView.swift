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
                
//                HStack {
//                    FilterButton(title: "Recipe", activeFilter: $activeFilter, filterType: .recipe, text: $recipe)
//                    FilterButton(title: "Area", activeFilter: $activeFilter, filterType: .area, text: $area)
//                    FilterButton(title: "Ingredient", activeFilter: $activeFilter, filterType: .ingredient, text: $ingredient)
//                    FilterButton(title: "Category", activeFilter: $activeFilter, filterType: .category, text: $category)
//                }
                
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
//                        networking.fetchIdData(idMeal: \.idMeal)
                    })
                }
                .padding()
            }
                
        }
    }
}


//// Button View Struct that shows Textfield for each Button
//struct FilterButton: View {
//    var title: String
//// Active variable that toggles if the the button is clicked
//    @Binding  var activeFilter: ContentView.FilterType?
//    var filterType: ContentView.FilterType
//    @Binding var text: String
//
//    var body: some View {
//        VStack {
//// Button created with action that confirms if the activeFilter clicked         matches the filterType cases
//            Button(action: {
//                activeFilter = (activeFilter == filterType) ? nil : filterType
//            }) {
////                Sets up the actual Button Title, font and button shape
//                Text(title)
//                    .font(.subheadline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
//                    .background(Color(UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)))
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//            }
////  Conditional for if the filter types match the activeFilter variable if it does than a textfield appears.
//            if activeFilter == filterType {
//                TextField("Type \(title) Filter", text: $text)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                    .background(Color(UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)))
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//            }
//        }
//    }
//}
    


#Preview {
   RecipeHome()
}
