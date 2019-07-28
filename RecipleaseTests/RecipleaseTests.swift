//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 04/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease


class RecipleaseTests: XCTestCase {
    
    // MARK: - FoodService

    func testFoodServiceAddMethodShouldPostNilIfNoElement() {
        let foodService = FoodService()
        XCTAssertTrue(foodService.foodArray.isEmpty)
    }
    
    func testFoodServiceAddMethodShouldPostTrueIfHaveElement() {
        let foodService = FoodService()
        let aFood = Food(name: "lemon")
        foodService.add(food: aFood)
        XCTAssertFalse(foodService.foodArray.isEmpty)
    }
    
    func testFoodServiceDeleteAllMethodShouldPostTrueIfHaveElement() {
        let foodService = FoodService()
        let aFood = Food(name: "lemon")
        let aFood2 = Food(name: "sausage")
        foodService.add(food: aFood)
        foodService.add(food: aFood2)
        foodService.deleteAll()
        XCTAssertTrue(foodService.foodArray.isEmpty)
    }
    
    
    // MARK: - YummlyService
    // MARK: - GetRecipes
    
    
    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertFalse(success)
            XCTAssertNil(matches)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertFalse(success)
            XCTAssertNil(matches)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeIncorrectData, error: nil)
        
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertFalse(success)
            XCTAssertNil(matches)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeCorrectData, error: nil)
        
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertFalse(success)
            XCTAssertNil(matches)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertFalse(success)
            XCTAssertNil(matches)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData, error: nil)
        
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, matches) in
            XCTAssertTrue(success)
            XCTAssertNotNil(matches)
            XCTAssertEqual(matches?.first?.id, "Flat-Belly-_-Weight-Loss-Detox-Water-2658056")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: - getRecipeDescription
    
    func testGetRecipeDescriptionShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipeDescription(id: "") { (success, description) in
            XCTAssertFalse(success)
            XCTAssertNil(description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeDescritonShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)

        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipeDescription(id: "") { (success, description) in
            XCTAssertFalse(success)
            XCTAssertNil(description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeDescritionShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeIncorrectData, error: nil)

        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipeDescription(id: "") { (success, description) in
            XCTAssertFalse(success)
            XCTAssertNil(description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeDescriptionShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeDescriptionCorrectData, error: nil)

        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipeDescription(id: "") { (success, description) in
            XCTAssertFalse(success)
            XCTAssertNil(description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeDescriptionShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)

        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(textTosearch: "lemon") { (success, description) in
            XCTAssertFalse(success)
            XCTAssertNil(description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeDescriptionShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeDescriptionCorrectData, error: nil)

        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipeDescription(id: "") { (success, description) in
        
            XCTAssertTrue(success)
            XCTAssertNotNil(description)
            XCTAssertTrue(description?.name == "Flat Belly & Weight Loss Detox Water")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: - CoreData
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
    //Recipe.deleteRecipe
    func testDeleteRecipeInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        try? mockContainer.viewContext.save()
        Recipe.deleteRecipe(recipe: recipe, viewContext: mockContainer.viewContext)
        XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    //Recipe.isRegistered
    func testIsRegisteredInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.id = "Flat-Belly-_-Weight-Loss-Detox-Water-2658056"
        try? mockContainer.viewContext.save()
        XCTAssertTrue(Recipe.isRegistered(id: "Flat-Belly-_-Weight-Loss-Detox-Water-2658056", viewContext: mockContainer.viewContext))
        
    }
    
    func testIsRegisteredShouldReturnFalseIfNotRecipeInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.id = "A false id"
        try? mockContainer.viewContext.save()
        XCTAssertFalse(Recipe.isRegistered(id: "Flat-Belly-_-Weight-Loss-Detox-Water-2658056", viewContext: mockContainer.viewContext))
        
    }
    
    //Recipe.search
    func testSearchMethodReturnEmptyArrayIfNotCorrespondantNameInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        try? mockContainer.viewContext.save()
        let name = "erreur"
        let arrayOfRecipe = Recipe.search(name: name)
        XCTAssertTrue(arrayOfRecipe.isEmpty)
    }
    
    func testSearchMethodReturnARecipeIfCorrespondantNameInPersistentContainer() {
        let recipe = Recipe(context: mockContainer.viewContext)
        recipe.name = "Flat Belly & Weight Loss Detox Water"
        try? mockContainer.viewContext.save()
        let name = "Flat"
        let arrayOfRecipe = Recipe.search(name: name)
        XCTAssertFalse(arrayOfRecipe.isEmpty)
    }
    
    
    
    
    
    
    
}
