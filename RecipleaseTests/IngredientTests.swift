//
//  IngredientTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 30/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
@testable import Reciplease
import CoreData
class IngredientTests: XCTestCase {
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()

    func testCreateIngredientEntitiesShouldBeInViewContext() {
        let recipe = Recipe(context: mockContainer.viewContext)
        Ingredient.createIngredient(recipeEntitie: recipe, ingredientsName: ["chocolate"], viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredientList = try? mockContainer.viewContext.fetch(request) else {return }
        print("IngredientLine: ", ingredientList)
        XCTAssertEqual(ingredientList.count, 1)
        XCTAssertEqual(ingredientList.first?.name, "chocolate")
        
    }

}
