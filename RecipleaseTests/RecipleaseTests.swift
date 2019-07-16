//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 04/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {

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
    
    
}
