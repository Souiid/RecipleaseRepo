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
            XCTAssertEqual(matches?.first?.id, "Spicy-Roasted-Chickpeas-1071199")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
