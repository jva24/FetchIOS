//
//  NetworkingManager.swift
//  RecipeFetchOS
//
//  Created by Meto Ajagu on 12/14/23.
//

import Foundation
import SwiftUI
import Alamofire

class NetworkingManager: ObservableObject{
    @Published var recipes: [Meal] = []
    @Published var detailRecipes: [DetailMeal] = []
    
    let dessertURL: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let idURL: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
//    var type: Int
//
//    init(type: Int) {
//        self.type = type
//    }
    
    func fetchDessertData(){
        let url = dessertURL
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

    AF.request(url, method: .get)
        .responseDecodable(of: MealResponse.self, decoder: decoder) { response in
            switch response.result {
            case .success(let mealResponse):
                print("Success")
                print(mealResponse)
                DispatchQueue.main.async {
                    self.recipes = mealResponse.meals
                    print("Recipes count: \(self.recipes.count)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchIdData(idMeal: String) {
        if let encodedIdMeal = idMeal.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            let url = "\(idURL)\(encodedIdMeal)"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print("Request URL: \(url)")
            
        AF.request(url, method: .get)
            .responseDecodable(of: DetailMealResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let mealResponse):
                    print("Success")
                    print(mealResponse)
                    DispatchQueue.main.async {
                        self.detailRecipes = mealResponse.meals
                        print("DetailRecipes count: \(self.detailRecipes.count)")
                        print("API Response: \(response)")
                        print("Raw Response: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")")

                    }
                case .failure(let error):
                    print("Error: \(error)")
                    print("API Response: \(response)")
                }
            }
        }
        
    }
    
}
