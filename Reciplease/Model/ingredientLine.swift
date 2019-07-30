//
//  ingredientLine.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 01/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import CoreData

class IngredientLine: NSManagedObject {
   
    static func createIngredientLine(ingredientLines: [String], recipeEntitie: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        for ingredientLine in ingredientLines {
            let ingredientLineEntity = IngredientLine(context: viewContext)
            ingredientLineEntity.ingredient = ingredientLine
            ingredientLineEntity.recipe = recipeEntitie
        }
    }
}
