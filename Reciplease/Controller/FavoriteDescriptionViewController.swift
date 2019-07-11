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
       // recipeIngredientLabel.text
        guard let data = recipe.image else {
           //image par default
            return
        }
        recipeImageView.image = UIImage(data: data)
        
        //ingredientLineTextView.text = recipe
    }
   
    
    @IBAction func deleteToFavorites() {
        Recipe.deleteRecipe(recipe: recipe)
    }
    
    


}
