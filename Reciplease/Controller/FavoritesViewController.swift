//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 26/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Outlets / propreties / viewDidLoad
    var recipes = Recipe.fetchAll()
    var ifShowRecipe = false
    var arrayOfRecipe = [Recipe]()
    var index = 0
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib.init(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        
     }
    
   //MARK: - Actions / viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = Recipe.fetchAll()
        ifShowRecipe = false
        favoritesTableView.reloadData()
        favoritesTableView.isHidden = false
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        searchButton.setTitle("Search", for: .normal)
        
    }
    
    //Prepare informations for the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDescriptionVC" {
            
            if let recipeDescriptionVC = segue.destination as? RecipeDescriptionViewController {
                recipeDescriptionVC.favoris = true
                if !ifShowRecipe {
                    recipeDescriptionVC.recipeFav = recipes[index]
                }else {
                    recipeDescriptionVC.recipeFav = arrayOfRecipe[index]
                }
            }
        }
    }

    //Search a recipe
    @IBAction func search() {
     
        guard let textToSearch = searchBar.text else {return}
        arrayOfRecipe = Recipe.search(name: textToSearch)
        searchBar.text = ""
        if !arrayOfRecipe.isEmpty {
            ifShowRecipe = true
            searchBar.text = ""
            searchButton.setTitle("Cancel", for: .normal)
            searchBar.isHidden = true
        }else {
            ifShowRecipe = false
            searchButton.setTitle("Search", for: .normal)
            searchBar.isHidden = false
        }
        
        favoritesTableView.reloadData()
    }
    
    @IBAction func dimissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ifShowRecipe == false{
            return recipes.count
        }else{
            return arrayOfRecipe.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
        if ifShowRecipe == false{
            
            let recipe = recipes[indexPath.row]
            cell.recipe = recipe
            return cell
            
        }else{
            let recipe = arrayOfRecipe[indexPath.row]
            cell.recipe = recipe
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesTableView.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        index = indexPath.row
        performSegue(withIdentifier: "segueToDescriptionVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if recipes.isEmpty {
            label.text = "You have'nt recipe in favorites : Search a recipe / Select a recipe / Press on the star"
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            label.textColor = .darkGray
            label.numberOfLines = 0
            
            //textView.sizeThatFits(CGSize(width: 100, height: 100))
            return label
            
        }
        return label
    }
}
