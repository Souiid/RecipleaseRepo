//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 02/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets / propreties
    
   @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    
    // propreties (get set) to put informations in corrects Outlets (call for recipesList)
    var match: Match? {
        
        didSet{
            guard let match = self.match else {return}
            titleLabel.text = match.recipeName
            descriptionLabel.text = match.ingredients.joined(separator: ", ")
            let duration = match.totalTimeInSeconds / 60
            durationLabel.text = "Duration : " + String(duration) + " min"
            ratingLabel.text = "Rate: " + String(match.rating) + " / 5"
            
            if let stringUrl = match.smallImageUrls?[0] {
                guard let data = stringUrl.data else {return}
                recipeImageView.image = UIImage(data: data)
            }else{
               recipeImageView.image = UIImage(named: "defaultImage")
                
            }
        }
    }
    
     // propreties (get set) to put informations in corrects Outlets (call for favoritesList)
    var recipe: Recipe? {
        didSet{
            guard let recipe = recipe else {return}
            titleLabel.text = recipe.name
            let ingredientEntities = recipe.ingredients?.allObjects as? [Ingredient]
            let ingredients = ingredientEntities?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
            descriptionLabel.text = ingredients
           
            guard let totalTime = recipe.totalTime else {return}
            guard let totaltimeInt = Int(totalTime) else {return}
            guard let rate = recipe.rate else {return}
            
            
            durationLabel.text = "Duration : " + String(totaltimeInt / 60) + " min"
            ratingLabel.text = "Rate : " + rate + " / 5"
            guard let image = recipe.image else {
                recipeImageView.image = UIImage(named: "defaultImage")
                return}
            recipeImageView.image = UIImage(data: image)
        }
    }
}
