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
    
    //MARK: - Outlets / propreties / viewDidLoad
    
    var recipeDescription: RecipeDescriptionDecodable?
    var recipe: Match?
    var recipeFav: Recipe?
    var favoris = false
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentInformation()
      }
    
    //MARK: - ViewWillAppear and methods
    
    override func viewWillAppear(_ animated: Bool) {
        if !favoris {
            guard let recipe = recipe else {return}
            if Recipe.isRegistered(id: recipe.id) {
                favoriteButton.setImage(UIImage(named: "yellowStar"), for: .normal)
            }else {
                favoriteButton.setImage(UIImage(named: "yellowContourStar"), for: .normal)
            }
        }else {
            favoriteButton.setImage(UIImage(named: "yellowStar"), for: .normal)

        }
    }
    
    //Prepare different information to put in the correct views
    func presentInformation(){
        
       
        if !favoris {
            guard let recipeDescription = recipeDescription else {return}
            guard let recipe = recipe else {return}
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
        }else {
           guard let recipeFav = recipeFav else {return}
          
            let ingredientEntities = recipeFav.ingredients?.allObjects as? [Ingredient]
            let ingredients = ingredientEntities?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
            let ingredientLineEntities = recipeFav.ingredientLines?.allObjects as? [IngredientLine]
            let ingredientLine = ingredientLineEntities?.map({$0.ingredient ?? ""}).joined(separator: "\n")
            guard let duration = Int(recipeFav.totalTime ?? "0") else {return}
       
            
            recipeTitleLabel.text = recipeFav.name
            recipeIngredientsLabel.text = ingredients
            recipeDetailTextView.text = ingredientLine
            guard let rate = recipeFav.rate else {return}
            rateLabel.text = "Rate : " + String(rate) + " / 5"
            durationLabel.text = "Duration : " + String(duration / 60) + " min"
            guard let data = recipeFav.image else {
                recipeImage.image = UIImage(named: "defaultImage")
                return
            }
            recipeImage.image = UIImage(data: data)
            
        }
    }
    
    func presentInformationForRecipeFav() {
        guard let recipeFav = recipeFav else {
            return

        }
        print(recipeFav.name, recipeFav.id)
        let ingredientEntities = recipeFav.ingredients?.allObjects as? [Ingredient]
        let ingredients = ingredientEntities?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        let ingredientLineEntities = recipeFav.ingredientLines?.allObjects as? [IngredientLine]
        let ingredientLine = ingredientLineEntities?.map({$0.ingredient ?? ""}).joined(separator: "\n")
        guard let duration = Int(recipeFav.totalTime ?? "0") else {return}
   
        
        recipeTitleLabel.text = recipeFav.name
        recipeIngredientsLabel.text = ingredients
        recipeDetailTextView.text = ingredientLine
        guard let rate = recipeFav.rate else {return}
        rateLabel.text = "Rate : " + String(rate) + " / 5"
        durationLabel.text = "Duration : " + String(duration) + " min"
        guard let data = recipeFav.image else {
            recipeImage.image = UIImage(named: "defaultImage")
            return
        }
        recipeImage.image = UIImage(data: data)
    }
    
    func assignEntitiesToRecipe(recipeEntitie: Recipe) {
        guard let recipe = self.recipe else {return}
        guard let recipeDescription = recipeDescription else {return}
        for ingredient in recipe.ingredients {
            let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recipe = recipeEntitie
        }
        
        for ingredientLine in recipeDescription.ingredientLines {
            let ingredientLineEntity = IngredientLine(context: AppDelegate.viewContext)
            ingredientLineEntity.ingredient = ingredientLine
            ingredientLineEntity.recipe = recipeEntitie
        }
    }
    
   
    
    //Append a recipe in context
    func saveARecipe() {
       
        
        
        if !favoris {
            guard let recipe = recipe else {return}
            guard let recipeDescription = recipeDescription else {return}
            if !Recipe.isRegistered(id: recipe.id) {
                favoriteButton.setImage(UIImage(named: "yellowStar"), for: .normal)
                
                let recipeToSave = Recipe(context: AppDelegate.viewContext)
                recipeToSave.name = recipe.recipeName
                recipeToSave.rate = String(recipe.rating)
                recipeToSave.totalTime = String(recipe.totalTimeInSeconds)
                let stringURL = recipeDescription.images[0].hostedLargeURL
                recipeToSave.image = stringURL.data
                recipeToSave.id = recipe.id
                recipeToSave.source = recipeDescription.source.sourceRecipeURL
                
                assignEntitiesToRecipe(recipeEntitie: recipeToSave)
                try? AppDelegate.viewContext.save()
            }else {
                favoriteButton.setImage(UIImage(named: "yellowContourStar"), for: .normal)
                Recipe.deleteRecipe(id: recipe.id)
            
            }
       
        }else {
             guard let recipeFav = recipeFav else {return}
       
            Recipe.deleteRecipe(recipe: recipeFav)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    //Prepare URL to go on Safari get details of Recipe
    func getRecipeDetailsOnSafari(with stringUrl: String) {
        guard let url = URL(string: stringUrl) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
    //MARK: - Actions
    // Go on Safari to find recipe's details on the website
    @IBAction func getDirection() {
        guard let recipeDescription = recipeDescription else {return}
        guard let recipeFav = recipeFav else {return}
        if !favoris {
            getRecipeDetailsOnSafari(with: recipeDescription.source.sourceRecipeURL)
        }else {
            guard let source = recipeFav.source else {return}
            getRecipeDetailsOnSafari(with: source)
        }
    }
    // Add a recipe to favorite
    @IBAction func addToFavorite() {
        saveARecipe()
    }
}
