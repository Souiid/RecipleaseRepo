//
//  Recipes.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 15/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation


struct RecipesDecodable: Decodable {
   
    let matches: [Match]
    let totalMatchCount: Int

}

struct Match: Decodable {
    var id: String
    var ingredients: [String]
    var smallImageUrls: [String]?
    var recipeName: String
    var totalTimeInSeconds: Int
    var rating: Int
}



