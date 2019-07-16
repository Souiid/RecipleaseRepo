//
//  RecipeDescriptionViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 13/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDescriptionViewController: UIViewController {
    
    var recipeDescription: RecipeDescriptionDecodable!
  
   
    var recipe: Match!
  

   
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeTitleLabel.text = recipeDescription.name
        recipeIngredientsLabel.text = recipe.ingredients.joined(separator: ", ")
        recipeDetailTextView.text = recipeDescription.ingredientLines.joined(separator: "\n")
        rateLabel.text = "Rate : " + String(recipe.rating) + " / 5"
        durationLabel.text = "Duration : " + String(recipe.totalTimeInSeconds / 60) + " min"
        let stringURL = recipeDescription.images[0].hostedLargeURL
        guard let data = stringURL.data else {
            recipeImage.image = UIImage(named: "defaultImage")
            return}
        recipeImage.image = UIImage(data: data)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        if Recipe.isRegistered(name: recipe.recipeName) {
            favoriteButton.setImage(UIImage(named: "yellowStar"), for: .normal)
        }else {
            favoriteButton.setImage(UIImage(named: "yellowContourStar"), for: .normal)
        }
        
    }
    
    @IBAction func getDirection() {
        getRecipeDetailsOnSafari(with: recipeDescription.source.sourceRecipeURL)
    
    }
    
    @IBAction func addToFavorite() {
        let recipeToSave = Recipe(context: AppDelegate.viewContext)
        favoriteButton.setImage(UIImage(named: "yellowStar"), for: .normal)
        recipeToSave.name = self.recipe.recipeName
        recipeToSave.rate = String(self.recipe.rating)
        recipeToSave.totalTime = String(self.recipe.totalTimeInSeconds)
        let stringURL = recipeDescription.images[0].hostedLargeURL
        recipeToSave.image = stringURL.data
        for ingredient in recipe.ingredients {
            let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recipe = recipeToSave
        }
        
        for ingredientLine in recipeDescription.ingredientLines {
            let ingredientLineEntity = IngredientLine(context: AppDelegate.viewContext)
            ingredientLineEntity.ingredient = ingredientLine
            ingredientLineEntity.recipe = recipeToSave
        }
        
        try? AppDelegate.viewContext.save()
        print(Recipe.fetchAll())
    }
    
  func getRecipeDetailsOnSafari(with stringUrl: String) {
        guard let url = URL(string: stringUrl) else {
            
            return
        }
        let safariVC = SFSafariViewController(url: url)
        
       present(safariVC, animated: true)
    }
}
