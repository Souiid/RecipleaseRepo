//
//  FoodServiceTests.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 30/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import XCTest
@testable import Reciplease

class FoodServiceTests: XCTestCase {

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

}
