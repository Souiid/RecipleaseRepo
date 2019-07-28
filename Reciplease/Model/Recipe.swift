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
    // Request All recipes in viewContext
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipeList = try? viewContext.fetch(request) else {return []}
        return recipeList
    }
    
    //Delete one recipe from viewContext
    static func deleteRecipe(recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        viewContext.delete(recipe)
        try? viewContext.save()
    }
    
    // Verify if a recipe is registered
    static func isRegistered(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext)-> Bool {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipeList = try? viewContext.fetch(request) else {return false}
        if recipeList.isEmpty {
            return false
        }
        return true
        
    }
    // Search a recipe by name
    static func search(name: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe]{
       
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "name contains[cd] %@", name)
        guard let recipeList = try? viewContext.fetch(request) else {return []}
        if recipeList.isEmpty {
            return []
        }
        return recipeList
    }
    
    static func deleteRecipe(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipeList = try? viewContext.fetch(request) else {return}
        guard let recipe = recipeList.first else {return}
        viewContext.delete(recipe)
        try? viewContext.save()
    }
    
//    func createRecipe(viewContext: NSManagedObjectContext = AppDelegate.viewContext)-> Recipe{
//        let recipe = Recipe(context: viewContext)
//        return recipe
//        
//    }
}

