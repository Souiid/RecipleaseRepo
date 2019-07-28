//
//  RecipesListController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 15/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit


class RecipesViewController: UIViewController {
    
    //MARK: - Outlets / propreties / viewDidLoad
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipesTableView: UITableView!
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var index = 0
    
    
    var recipes = [Match]()
    var image = UIImage()
    var recipeTableviewCell = RecipeTableViewCell()
  
    var recipeDescription: RecipeDescriptionDecodable?
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        recipesTableView.register(UINib.init(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recipesTableView.isHidden = false
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    
    
    //Prepare informations to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeDescription" {
            
            if let recipeDescriptionVC = segue.destination as? RecipeDescriptionViewController {
                guard let recipeDescription = recipeDescription else {return}
                recipeDescriptionVC.recipeDescription = recipeDescription
                recipeDescriptionVC.recipe = recipes[index]
                recipeDescriptionVC.favoris = false
            }
        }
    }
}

 //All tableview methods
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
        recipesTableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let recipe = recipes[indexPath.row]
        index = indexPath.row
        let id = recipe.id
        YummlyService().getRecipeDescription(id: id) { (success, recipeDescription) in
            
            if success {
                self.recipeDescription = recipeDescription
                self.performSegue(withIdentifier: "segueToRecipeDescription", sender: self)
            }else {
                self.recipesTableView.isHidden = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        if recipes.isEmpty {
        
            label.text = "The search not success"
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            label.textColor = .darkGray
        }
        return label
    }
}


