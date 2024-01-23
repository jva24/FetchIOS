import SwiftUI
import SDWebImageSwiftUI
struct DetailedRecipeView: View {
    let idMeal: String
    @StateObject var networking = NetworkingManager()
    init(idMeal: String) {
        self.idMeal = idMeal

    }
    
    var ingredients: [String] {
        var result = [String]()
        for detailRecipe in networking.detailRecipes {
            result.append(contentsOf: extractIngredients(from: detailRecipe))
        }
        return result
    }
    
    var measurements: [String] {
        var result = [String]()
        for detailRecipe in networking.detailRecipes {
            result.append(contentsOf: extractMeasurements(from: detailRecipe))
        }
        return result
    }
    
    func extractIngredients(from detailRecipe: DetailMeal) -> [String] {
        var ingredients = [String]()
        let mirror = Mirror(reflecting: detailRecipe)

        for child in mirror.children {
            if let (key, value) = child as? (String, String), key.hasPrefix("strIngredient"), !value.isEmpty {
                ingredients.append(value)
            }
        }

        return ingredients
    }
    
    func extractMeasurements (from detailRecipe: DetailMeal) -> [String] {
        var measurements = [String]()
        let mirror = Mirror(reflecting: detailRecipe)

        for child in mirror.children {
            if let (key, value) = child as? (String, String), key.hasPrefix("strMeasure"), !value.isEmpty {
                measurements.append(value)
            }
        }

        return measurements
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(networking.detailRecipes, id: \.idMeal) { detailRecipe in
                        Text(detailRecipe.strMeal ?? "")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 30))
                        WebImage(url: URL(string: detailRecipe.strMealThumb ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(EdgeInsets(top: 30, leading: 60, bottom: 30, trailing: 30))
                        
                        if !networking.detailRecipes.isEmpty {
                            Section(header: Text("Ingredients:")
                                .font(.subheadline)
                                .foregroundColor(.blue)) {
                                    ForEach(ingredients, id: \.self) { ingredient in
                                        Text(ingredient)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                }
                            }
                            Section(header: Text("Measurements:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)) {
                                    ForEach(measurements, id: \.self) { measurement in
                                        Text(measurement)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                    }
                            }
                            Section(header: Text("Instructions:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)) {
                                    Text(detailRecipe.strInstructions ?? "")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            }
                            Section(header: Text("Area:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)) {
                                    Text(detailRecipe.strArea ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .foregroundColor(.black)

                            }
                            
                            Section(header: Text("Tags:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)){
                                    Text(detailRecipe.strTags ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .foregroundColor(.black)

                            }
                            Section(header: Text("Drink Alternate")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)) {
                                    Text(detailRecipe.strDrinkAlternate ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .foregroundColor(.black)
                            }
                            
                            Section(header: Text("YouTube Video:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)) {
                                    Link(destination: URL(string:detailRecipe.strYoutube ?? "")!, label: {
                                        Text(detailRecipe.strYoutube ?? "")
                                            .underline()
                                            .foregroundColor(.blue)
                                    })
                            }
                            
                            Section(header: Text("Source:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)) {
                                    Link(destination: URL(string:detailRecipe.strSource ?? "")!,label: {
                                        Text(detailRecipe.strSource ?? "")
                                            .underline()
                                            .foregroundColor(.blue)
                                    })
                            }
                        }
                    
                    
                }
                .onAppear(perform: {
                    networking.fetchIdData(idMeal: idMeal)
                })
            }
            .onAppear(perform: {
                networking.fetchIdData(idMeal: idMeal)
            })
        }
    }
}
#Preview {
    RecipeHome()
}
