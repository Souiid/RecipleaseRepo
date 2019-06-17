//
//  RecipesListController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 15/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit
import Alamofire

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipesTableView: UITableView!
   
    let recipeService = RecipeService()
    
    var recipes = [Match]()
    var image = UIImage()
    var recipeTableviewCell = RecipeTableViewCell()
    var index = 0
    var recipeDescription: RecipeDescriptionDecodable!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        recipesTableView.register(UINib.init(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        print(recipes)
        
        print("CALL DESCRIPTION ++++++")
        YummlyService().getRecipeDescription(id: "Spicy-Roasted-Chickpeas-1071199") { (success, description) in
            print("OK")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeDescription" {
            
            if let recipeDescriptionVC = segue.destination as? RecipeDescriptionViewController {
                guard let recipeDescription = recipeDescription else {return}
                recipeDescriptionVC.recipeDescription = recipeDescription
            }
        }
    }

}
    
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipesTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
       
        let recipe = recipes[indexPath.row]
        cell.match = recipe
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let id = recipe.id
        YummlyService().getRecipeDescription(id: id) { (success, recipeDescription) in
            if success {
                self.recipeDescription = recipeDescription
                self.performSegue(withIdentifier: "segueToRecipeDescription", sender: self)
            }
        }
    }
}


