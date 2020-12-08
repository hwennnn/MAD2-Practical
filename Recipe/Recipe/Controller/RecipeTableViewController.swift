//
//  RecipeTableViewController.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import Foundation
import UIKit

class RecipeTableViewContoller : UITableViewController{
    
    var recipeList:[Recipe] = []
    let recipeController = RecipeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeList = recipeController.retrieveAllRecipe()
        self.tableView.reloadData() //refresh data
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let recipe = recipeList[indexPath.row]
        cell.textLabel!.text = "\(recipe.name) \(recipe.preparationTime)"
//        var ingredients:String = ""
//
//        cell.detailTextLabel!.text. =
        
        return cell
         
    }
     
}

