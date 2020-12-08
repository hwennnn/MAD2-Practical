//
//  AddRecipeViewController.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import Foundation
import UIKit

class AddRecipeViewContoller : UIViewController{
    
    let recipeController = RecipeController()
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipePrepTime: UITextField!
    
    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    @IBOutlet weak var ingredient4: UITextField!
    @IBOutlet weak var ingredient5: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func AddRecipe(_ sender: Any) {
        if (checkTitleAndTime() && checkIngredient()){
            var ingredientList:[Ingredient] = []
            if !ingredient1.text!.isEmpty{
                ingredientList.append(Ingredient(ingredient1.text!))
            }
            if !ingredient2.text!.isEmpty{
                ingredientList.append(Ingredient(ingredient2.text!))
            }
            if !ingredient3.text!.isEmpty{
                ingredientList.append(Ingredient(ingredient3.text!))
            }
            if !ingredient4.text!.isEmpty{
                ingredientList.append(Ingredient(ingredient4.text!))
            }
            if !ingredient5.text!.isEmpty{
                ingredientList.append(Ingredient(ingredient5.text!))
            }
            
            
            let recipe:Recipe = Recipe(recipeTitle.text!, Int16(recipePrepTime.text!)!, ingredientList)
            recipeController.AddRecipe(newRecipe: recipe)
            
            popSucess()
            
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
    
    func popSucess(){
        let alertView = UIAlertController(title: "Data Added", message: "A recipe is added to database.", preferredStyle: UIAlertController.Style.alert)
                
        alertView.addAction(UIAlertAction(title: "Done",style: UIAlertAction.Style.default, handler: { _ in }))
        
        self.present(alertView, animated: true, completion: nil)
    }
}
