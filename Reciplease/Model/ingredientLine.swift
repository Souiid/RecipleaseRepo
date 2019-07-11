//
//  ingredientLine.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 01/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import CoreData

class IngredientLine: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientLine] {
        let request: NSFetchRequest<IngredientLine> = IngredientLine.fetchRequest()
        guard let ingredientLineList = try? viewContext.fetch(request) else {return []}
        return ingredientLineList
    }
}
