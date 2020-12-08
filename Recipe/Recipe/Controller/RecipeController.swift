//
//  RecipeController.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import UIKit
import Foundation
import CoreData

class RecipeController: UIViewController {
    
    // Add a new Recipe to Core Data
    func AddRecipe(newRecipe:Recipe){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDRecipe", in: context)!
        
        let contact = NSManagedObject(entity: entity, insertInto: context)
        contact.setValue(newRecipe.name, forKey: "name")
        contact.setValue(newRecipe.preparationTime, forKey: "preparationTime")
        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        for ingredient in newRecipe.ingredient{
            AddIngredient(newRecipe, ingredient)
        }
        
    }
    
    // Add a new Ingredient to Core Data
    func AddIngredient(_ recipe:Recipe, _ newIngredient:Ingredient){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDIngredient", in: context)!
        
        let ingredient = NSManagedObject(entity: entity, insertInto: context) as! CDIngredient
        ingredient.setValue(newIngredient.name, forKey: "name")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        fetchRequest.predicate = NSPredicate(format: "name = %@", recipe.name)
        
        do{
            let CDRecipe = try context.fetch(fetchRequest)
            let r = CDRecipe[0] as! CDRecipe
            
            ingredient.addToRecipes(r)
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    // Retrieve all contact from Core Data
    func retrieveAllRecipe() -> [Recipe] {
        var recipeList:[Recipe] = []
        var fetchedList:[NSManagedObject] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        do {
            fetchedList = try context.fetch(fetchRequest)
            print(fetchedList.count)
            for c in fetchedList{
                let name = c.value(forKey: "name") as? String
                let preparationTime = c.value(forKey: "preparationTime") as? Int16
                let ingredient = c.value(forKey: "ingredients") 
                
                print(name!, preparationTime!, ingredient)
//                let recipe = Recipe(name!, preparationTime!, ingredient!)
//                recipeList.append(recipe)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return recipeList
    }
    
}

