//
//  RecipeTableViewController.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import Foundation
import UIKit

class RecipeTableViewContoller : UITableViewController{
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let recipeController = RecipeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData() //refresh data
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let recipe = appDelegate.recipeList[indexPath.row]

        cell.textLabel!.text = "\(recipe.name) (\(recipe.preparationTime) mins)"
        
        var ingredientsText:String = "Ingredients:"
        for i in recipe.ingredient{
            ingredientsText += " [\(i.name)]"
        }

        cell.detailTextLabel!.text = ingredientsText
        
        return cell
         
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editHandler(indexPath.row)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [action])

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let recipe = self.appDelegate.recipeList[indexPath.row]
            
            recipeController.deleteRecipeRelationship(recipe)
            recipeController.deleteRecipe(recipe)
            recipeController.deleteIngredients(recipe.ingredient)
            
            // refresh data
            appDelegate.recipeList = recipeController.retrieveAllRecipe()
        }
        
        self.tableView.reloadData()
    }
    
    func editHandler(_ index: Int){
        performSegue(withIdentifier: "newRecipe", sender: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newRecipe", let destination = segue.destination as? AddRecipeViewContoller {
            if let s = sender as? Int{
                destination.recipeIndex = s
            }
        }
    }
     
}

