//
//  AddRecipeViewController.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import Foundation
import UIKit

class AddRecipeViewContoller : UIViewController{
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let recipeController = RecipeController()
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipePrepTime: UITextField!
    
    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    @IBOutlet weak var ingredient4: UITextField!
    @IBOutlet weak var ingredient5: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    var ingredients:[UITextField]?
    
    var recipeIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredients = [ingredient1,ingredient2,ingredient3,ingredient4,ingredient5]
        
        if let index = recipeIndex{
            let recipe:Recipe = appDelegate.recipeList[index]
            recipeTitle.text = recipe.name
            recipePrepTime.text = String(recipe.preparationTime)
            
            for (idx,ing) in recipe.ingredient.enumerated(){
                ingredients![idx].text = ing.name
            }
            
            updateButton.isHidden = false
            addButton.isHidden = true
            
        }else{
            updateButton.isHidden = true
            addButton.isHidden = false
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func AddRecipe(_ sender: Any) {
        if (checkTitleAndTime() && checkIngredient()){
            var ingredientList:[Ingredient] = []
           
            for i in ingredients!{
                if !i.text!.isEmpty{
                    ingredientList.append(Ingredient(i.text!))
                }
            }
            
            
            let recipe:Recipe = Recipe(recipeTitle.text!, Int16(recipePrepTime.text!)!, ingredientList)
            recipeController.AddRecipe(newRecipe: recipe)
            
            // update recipeList after adding a recipe
            appDelegate.recipeList = recipeController.retrieveAllRecipe()
            
            popSucess("added")
            
            recipeTitle.text = ""
            recipePrepTime.text = ""
            ingredient1.text = ""
            ingredient2.text = ""
            ingredient3.text = ""
            ingredient4.text = ""
            ingredient5.text = ""
        }
    }
    
    func checkTitleAndTime() -> Bool{
        let isValid:Bool = !recipeTitle.text!.isEmpty && !recipePrepTime.text!.isEmpty
        
        if (!isValid){
            let alertView = UIAlertController(title: "Empty Field", message: "Please populate the title and preparation time", preferredStyle: UIAlertController.Style.alert)
                    
            alertView.addAction(UIAlertAction(title: "Noted",style: UIAlertAction.Style.default, handler: { _ in }))
            
            self.present(alertView, animated: true, completion: nil)
        }
        
        return isValid
    }
    
    func checkIngredient() -> Bool{
        let isValid = !ingredient1.text!.isEmpty ||
                        !ingredient2.text!.isEmpty ||
                        !ingredient3.text!.isEmpty ||
                        !ingredient4.text!.isEmpty ||
                        !ingredient5.text!.isEmpty
        
        if (!isValid){
            let alertView = UIAlertController(title: "Empty Field", message: "Please populate at least one ingredient", preferredStyle: UIAlertController.Style.alert)
                    
            alertView.addAction(UIAlertAction(title: "Noted",style: UIAlertAction.Style.default, handler: { _ in }))
            
            self.present(alertView, animated: true, completion: nil)
        }
        
        return isValid
    }
    
    func popSucess(_ action:String){
        let alertView = UIAlertController(title: "Data \(action)", message: "The recipe is \(action) to database.", preferredStyle: UIAlertController.Style.alert)
                
        alertView.addAction(UIAlertAction(title: "Done",style: UIAlertAction.Style.default, handler: { _ in }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func updateRecipe(_ sender: Any) {
        if checkTitleAndTime() && checkIngredient(){
            var ingredientList:[Ingredient] = []
           
            for i in ingredients!{
                if !i.text!.isEmpty{
                    ingredientList.append(Ingredient(i.text!))
                }
            }
            
            let old:Recipe = appDelegate.recipeList[recipeIndex!]
            let recipe:Recipe = Recipe(recipeTitle.text!, Int16(recipePrepTime.text!)!, ingredientList)
            
            recipeController.updateRecipe(old, recipe)
            recipeController.updateIngredient(recipe, old.ingredient)
            // TODO: updateIngredients
            appDelegate.recipeList = recipeController.retrieveAllRecipe()
            
            popSucess("updated")
        }
    }
}
