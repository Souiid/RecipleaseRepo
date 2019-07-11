//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 26/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var recipes = Recipe.fetchAll()
    var index = 0
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib.init(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        print(Recipe.fetchAll())
     
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = Recipe.fetchAll()
        favoritesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavDescriptionVC" {
            
            if let favDescriptionVC = segue.destination as? FavoriteDescriptionViewController {
                // Passer le titre, les ingredients, l'image, ingredientline
                
                favDescriptionVC.recipe = recipes[index]
                
              //  guard let recipeDescription = recipeDescription else {return}
                //recipeDescriptionVC.recipeDescription = recipeDescription
               // recipeDescriptionVC.recipe = recipes[index]
            }
        }
    }

}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
        
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        index = indexPath.row
        performSegue(withIdentifier: "segueToFavDescriptionVC", sender: self)
    }

    
}
