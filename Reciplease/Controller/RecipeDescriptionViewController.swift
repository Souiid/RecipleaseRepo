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
    var recipesIngredients: [String]!
    var recipeService: RecipeService!
   
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeTitleLabel.text = recipeDescription.name
        recipeIngredientsLabel.text = recipesIngredients.joined(separator: ", ")
        recipeDetailTextView.text = recipeDescription.ingredientLines.joined(separator: "\n")
        let stringURL = recipeDescription.images[0].hostedLargeURL
        print("recipeDescriptionImage: ", stringURL)
        RecipeService().downloadImage(with: stringURL) { (data) in
            guard let data = data else {return}
            self.recipeImage.image = UIImage(data: data)
        }
        
    }
    
    @IBAction func getDirection() {
        getRecipeDetailsOnSafari(with: recipeDescription.source.sourceRecipeURL)
    
    }
    
    
    @IBAction func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func getRecipeDetailsOnSafari(with stringUrl: String) {
        guard let url = URL(string: stringUrl) else {
            
            return
        }
        let safariVC = SFSafariViewController(url: url)
        
       present(safariVC, animated: true)
    }
}
