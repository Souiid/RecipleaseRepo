//
//  Ingredient.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 01/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
  
    static func createIngredient(recipeEntitie: Recipe, ingredientsName: [String],viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        for name in ingredientsName {
            let ingredientEntitie = Ingredient(context: viewContext)
            ingredientEntitie.name = name
            ingredientEntitie.recipe = recipeEntitie
        }
    }
}


