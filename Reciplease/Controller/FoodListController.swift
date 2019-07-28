//
//  ViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 13/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit


class FoodViewController: UIViewController {
    
    //MARK: - Outlets / propreties / viewDidLoad

    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var inputFoodTextField: UITextField!
    @IBOutlet weak var yourIngredientsLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    let foodService = FoodService()
    var food = Food(name: "")
    let yummlyService = YummlyService()
    var recipes : [Match]?
    var foodNameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourIngredientsLabel.isHidden = true
        clearButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicator.isHidden = true
        searchButton.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    //MARK: - Actions
    
    // Append food in List
    @IBAction func appendFoodToList() {
       
        guard let foodName = inputFoodTextField.text else {return}
        food.name = foodName
        foodService.add(food: food)
        foodTableView.reloadData()
        inputFoodTextField.text = ""
    }
    
    // Delete all food in list
    @IBAction func deleteAll() {
        foodService.deleteAll()
        foodNameArray.removeAll()
        foodTableView.reloadData()
    }
    
    // Get all recipes according user's selection
    @IBAction func showRecipes() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchButton.isHidden = true
        for food in foodService.foodArray {
            foodNameArray.append(food.name)
        }
        
        let textTosearch = foodNameArray.joined(separator: "&allowedIngredient%5B%5D=")
        yummlyService.getRecipes(textTosearch: textTosearch) { (success, recipes) in
            
           if success {
                self.recipes = recipes
                self.performSegue(withIdentifier: "segueToRecipesList", sender: self)
            
            }
        }
        
//        activityIndicator.isHidden = true
//        searchButton.isHidden = false
//        activityIndicator.stopAnimating()
    }
    
    //To come back in this view controller from RecipeDescription
    @IBAction func unwindToFoodList(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesList" {
            
            if let recipesVC = segue.destination as? RecipesViewController {
                guard let recipes = recipes else {return}
                print(recipes)
                recipesVC.recipes = recipes
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
        inputFoodTextField.resignFirstResponder()
    }
    
}

// All tableview methods 
extension FoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodService.foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodTableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        let food = foodService.foodArray[indexPath.row]
        cell.textLabel?.text = food.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        if foodService.foodArray.isEmpty {
          
            label.text = "Add foods in list"
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            label.textColor = .white
            yourIngredientsLabel.isHidden = true
            clearButton.isHidden = true
        }else {
            yourIngredientsLabel.isHidden = false
            clearButton.isHidden = false
        }
        return label
    }
    

    
}




