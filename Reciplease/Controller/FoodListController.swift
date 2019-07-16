//
//  ViewController.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 13/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import UIKit
import CoreData

class FoodViewController: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var inputFoodTextField: UITextField!
    
    let foodService = FoodService()
    var food = Food(name: "")
    let yummlyService = YummlyService()
    var recipes : [Match]?
    var foodNameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func appendFoodToList() {
       
        guard let foodName = inputFoodTextField.text else {return}
        food.name = foodName
        foodService.add(food: food)
        foodTableView.reloadData()
        inputFoodTextField.text = ""
    }
    
    @IBAction func deleteAll() {
        foodService.deleteAll()
        foodTableView.reloadData()
    }
    
    
    @IBAction func showRecipes() {
  
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
    }
    
    @IBAction func unwindToFoodList(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesList" {
            
            if let recipesVC = segue.destination as? RecipesViewController {
                guard let recipes = recipes else {return}
                recipesVC.recipes = recipes
            }
        }
    }
}

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
            label.textColor = .darkGray
            //return label
        }
        return label
    }
    

    
}




