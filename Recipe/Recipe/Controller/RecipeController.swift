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
        
        let recipe = NSManagedObject(entity: entity, insertInto: context) as! CDRecipe
        recipe.setValue(newRecipe.name, forKey: "name")
        recipe.setValue(newRecipe.preparationTime, forKey: "preparationTime")
        
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
    
    // Retrieve all recipes from Core Data
    func retrieveAllRecipe() -> [Recipe] {
        var recipeList:[Recipe] = []
        var recipes:[CDRecipe] = []
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<CDRecipe>(entityName: "CDRecipe")
        do {
            recipes = try context.fetch(fetchRequest)

            for r in recipes{
                let name = r.name
                let preparationTime = r.preparationTime
                var ingredients:[Ingredient] = []
                
                // read recipe' ingredients by casting it to set
                for i in r.ingredients as! Set<CDIngredient>{
                    ingredients.append(Ingredient(i.name!))
                }

                let recipe = Recipe(name!, preparationTime, ingredients)
                recipeList.append(recipe)
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return recipeList
    }
    
    func updateRecipe(_ old:Recipe, _ recipe:Recipe){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", old.name)
        do {
            let fetched = try context.fetch(fetchRequest)
            
            let r = fetched[0] as NSManagedObject
            r.setValue(recipe.name, forKey: "name")
            r.setValue(recipe.preparationTime, forKey: "preparationTime")
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteRecipeRelationship(_ recipe:Recipe){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CDRecipe>(entityName: "CDRecipe")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", recipe.name)
        do {
            let fetched = try context.fetch(fetchRequest)
            
            let r = fetched[0] as CDRecipe
            let ing:NSSet = r.ingredients!
            r.removeFromIngredients(ing)

            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteIngredients(_ ingredients:[Ingredient]){
        for ing in ingredients{
            let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDIngredient")
            
            fetchRequest.predicate = NSPredicate(format: "name = %@", ing.name)
            
            do {
                let fetched = try context.fetch(fetchRequest)
            
                let f = fetched[0] as NSManagedObject
                context.delete(f)
                
                do{
                    try context.save()
                } catch let error as NSError{
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            } catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func updateIngredient(_ recipe:Recipe, _ ingredients:[Ingredient]){
        deleteRecipeRelationship(recipe) // delete relationships between recipe and ingredients
        deleteIngredients(ingredients) // delete old ingredients
        for ing in recipe.ingredient{ // add new ingredients
            AddIngredient(recipe, ing)
        }
    }
    
    func deleteRecipe(_ recipe:Recipe){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", recipe.name)
        
        do {
            let fetched = try context.fetch(fetchRequest)
        
            let f = fetched[0] as NSManagedObject
            context.delete(f)
            
            do{
                try context.save()
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

