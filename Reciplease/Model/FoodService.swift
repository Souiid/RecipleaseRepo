//
//  FoodService.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 14/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation

class FoodService {
    var foodArray = [Food]()
    
    func add(food: Food) {
        foodArray.append(food)
    }
    
    func deleteAll() {
        foodArray.removeAll()
    }
}
