//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 02/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
   @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    
    var match: Match! {
        didSet{
            titleLabel.text = match.recipeName
            descriptionLabel.text = match.ingredients.joined(separator: ", ")
            let duration = match.totalTimeInSeconds / 60
            durationLabel.text = "Duration : " + String(duration) + " min"
            ratingLabel.text = String(match.rating)
            
            if let stringUrl = match.smallImageUrls?[0] {
                RecipeService().downloadImage(with: stringUrl) { (data) in
                    guard let data = data else {return}
                    self.recipeImageView.image = UIImage(data: data)
                }
                
            }else{
               // recipeImageView.image = 
                
            }
        }
    }
}
