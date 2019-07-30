//
//  IngredientLineTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 30/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
@testable import Reciplease
import CoreData

class IngredientLineTests: XCTestCase {
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()

    func testCreateIngredienLinetEntitiesShouldBeInViewContext() {
        let recipe = Recipe(context: mockContainer.viewContext)
        IngredientLine.createIngredientLine(ingredientLines: ["1 chocolate"], recipeEntitie: recipe, viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        let request: NSFetchRequest<IngredientLine> = IngredientLine.fetchRequest()
        guard let ingredientLineList = try? mockContainer.viewContext.fetch(request) else {return }
        XCTAssertEqual(ingredientLineList.count, 1)
        XCTAssertEqual(ingredientLineList.first?.ingredient, "1 chocolate")
        
    }

}
