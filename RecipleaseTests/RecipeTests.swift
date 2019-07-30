//
//  RecipeTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 30/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
@testable import Reciplease
import CoreData
class RecipeTests: XCTestCase {

    //MARK: - Properties
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    //MARK: - CoreData(Recipe)
    //MARK: - Helper Method
    private func addRecipeToFavorite(into managedObjectContext: NSManagedObjectContext) {
        let newRecipe = Recipe(context: managedObjectContext)
        newRecipe.name = "Flat Belly & Weight Loss Detox Water"
    }
    
    //MARK: - Unit Tests
    //Save a recipe
    func testInsertManyRecipesInPersistentContainer() {
        for _ in 0 ..< 1000 {
            addRecipeToFavorite(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    //MARK: - Recipe.delteRecipe
  func testDeleteRecipeInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        recipe.id = "recipeId"
        try? mockContainer.viewContext.save()
        Recipe.deleteRecipe(recipe: recipe, viewContext: mockContainer.viewContext)
        XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testDeleteRecipeIDInPrersistentcontainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        
        recipe.id = "recipeId"
        try? mockContainer.viewContext.save()
        Recipe.deleteRecipe(id: "recipeId", viewContext: mockContainer.viewContext)
        XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    //MARK: - Recipe.isRegistered
    func testIsRegisteredInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.id = "Flat-Belly-_-Weight-Loss-Detox-Water-2658056"
        try? mockContainer.viewContext.save()
        XCTAssertTrue(Recipe.isRegistered(id: "Flat-Belly-_-Weight-Loss-Detox-Water-2658056", viewContext: mockContainer.viewContext))
    }
    
    //MARK: - Recipe.search(id)
    func testIsRegisteredShouldReturnFalseIfNotRecipeInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.id = "A false id"
        try? mockContainer.viewContext.save()
        XCTAssertFalse(Recipe.isRegistered(id: "Flat-Belly-_-Weight-Loss-Detox-Water-2658056", viewContext: mockContainer.viewContext))
    }
    
    //MARK: - Recipe.search(name)
    func testSearchMethodReturnEmptyArrayIfNotCorrespondantNameInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        try? mockContainer.viewContext.save()
        let name = "erreur"
        let arrayOfRecipe = Recipe.search(name: name, viewContext: mockContainer.viewContext)
        XCTAssertTrue(arrayOfRecipe.isEmpty)
    }
    
    func testSearchMethodReturnARecipeIfCorrespondantNameInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        try? mockContainer.viewContext.save()
        let name = "Flat"
        let arrayOfRecipe = Recipe.search(name: name, viewContext: mockContainer.viewContext)
        XCTAssertFalse(arrayOfRecipe.isEmpty)
    }
    
    //MARK: - Recipe.createRecipe
    func testCreateRecipeShouldBeRegistered() {
        let _ = Recipe.createRecipe(name: "Chocolate", rate: 5, totalTime: 5, url: "recipe.com", id: "recipeID", source: "recipe.com", viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(Recipe.isRegistered(id: "recipeID", viewContext: mockContainer.viewContext))
        
    }

}
