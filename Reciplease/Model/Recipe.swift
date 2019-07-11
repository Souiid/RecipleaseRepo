//
//  Recipe.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 01/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipeList = try? viewContext.fetch(request) else {return []}
        return recipeList
    }
    
    static func deleteRecipe(recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        //Recipe.fetchAll(viewContext: viewContext).startIndex({viewContext.delete($0)})
  
        viewContext.delete(recipe)
        
        
       // Recipe.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
}

