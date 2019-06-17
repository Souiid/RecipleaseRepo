//
//  yummlyService.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 15/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation

class YummlyService {
    
    private var yummlySession: YummlySession
    
    init(yummlySession: YummlySession = YummlySession()) {
        self.yummlySession = yummlySession
    }
    

    func getRecipes(textTosearch: String, completionHandler: @escaping (Bool, [Match]?) -> Void) {
        
        
        let baseURL = "http://api.yummly.com/v1/api/recipes?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9&allowedIngredient%5B%5D="
        
        guard let textEncoded = textTosearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let stringUrl = baseURL + textEncoded
        let url = URL(string: stringUrl)

        yummlySession.request(url: url!) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipes = try? JSONDecoder().decode(RecipesDecodable.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipes.matches)
        }
    }
    
    func getRecipeDescription(id: String, completionHandler: @escaping (Bool, RecipeDescriptionDecodable?) -> Void) {
        
        
        let baseURL = "http://api.yummly.com/v1/api/recipe/"
        
        guard let textEncoded = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let stringUrl = baseURL + textEncoded + "?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9"
        let url = URL(string: stringUrl)
        print("URL : ", stringUrl)
        
        yummlySession.request(url: url!) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeDescription = try? JSONDecoder().decode(RecipeDescriptionDecodable.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            print(recipeDescription)
            completionHandler(true, recipeDescription)
            
        }
    }
}
