//
//  Recipe.swift
//  Recipe
//
//  Created by hwen on 8/12/20.
//

import Foundation

class Recipe{
    var name: String
    var preparationTime: Int16
    var ingredient: [Ingredient]
    
    init(_ Name:String,_ PreparationTime:Int16, _ ingredientList: [Ingredient]) {
        name = Name
        preparationTime = PreparationTime
        ingredient = ingredientList
    }
}
