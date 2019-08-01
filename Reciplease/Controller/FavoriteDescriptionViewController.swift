//
//  FavoriteDescriptionViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 09/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit

class FavoriteDescriptionViewController: UIViewController {
    
    var recipe = Recipe()
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    @IBOutlet weak var recipeIngredientLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var ingredientLineTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitleLabel.text = recipe.name
        let ingredientEntities = recipe.ingredients?.allObjects as? [Ingredient]
        let ingredients = ingredientEntities?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        recipeIngredientLabel.text = ingredients
        
        let ingredientLineEntities = recipe.ingredientLines?.allObjects as? [IngredientLine]
        let ingredientLine = ingredientLineEntities?.map({$0.ingredient ?? ""}).joined(separator: "\n ") ?? ""
        ingredientLineTextView.text = ingredientLine
        guard let data = recipe.image else {
           //image par default
            return
        }
        recipeImageView.image = UIImage(data: data)
    }
   
    
    @IBAction func deleteToFavorites() {
        Recipe.deleteRecipe(recipe: recipe)
    }
    
    


}
