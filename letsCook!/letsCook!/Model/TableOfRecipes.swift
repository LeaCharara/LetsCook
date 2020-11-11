//
//  TableOfRecipes.swift
//  letsCook!
//
//  Created by Lea Charara on 4/22/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation
import UIKit


class TableOfRecipes {
     private var Recipes = [(Recipe(Title: "Sandwich", D: "Grilled chicken breast, skin-on fries, crisp lettuce, fresh tomato slices, tangy pickles and aioli sauce.", R: Float(3), I: UIImage(named: "initialBackground1")!, user: "Test", c: .Sandwich, s: [Step(text: "Spread the aioli sauce on the bread", checked : false),Step(text: "Cook the chicken with sesame oil", checked : false),Step(text: "Cut the lettuce and tomatoes", checked : false),Step(text: "Melt the cheese and add it in the bread", checked : false),Step(text: "Put everything inside your bread and voilà!", checked : false)], i: [Ingredient(Name: "Tomatoes",Quantity: "4", checked: false),Ingredient(Name: "Crisp Lettuce",Quantity: "2", checked: false),Ingredient(Name: "Chicken slices",Quantity: "300g", checked: false),Ingredient(Name: "Pickles",Quantity: "10", checked: false)], f: false)),(Recipe(Title: "Cuban Burger", D: "Grilled beef patty topped with grilled onions and green peppers, jalapeños, melted cheddar cheese, crisp lettuce, a fresh tomato slice and the delicious Cuban sauce.", R: Float(4), I: UIImage(named: "initialBackground2")!, user: "ElMexicano", c: .Burger, s: [Step(text: "Cook your beef patty", checked : false),Step(text: "Prepare the Cuban sauce", checked : false),Step(text: "Cut the vegetables into fine slices", checked : false),Step(text: "Spread your Cuban sauce inside the bun", checked : false),Step(text: "Add everything in the bun", checked : false)], i: [Ingredient(Name: "Beef",Quantity: "1", checked: false),Ingredient(Name: "Tomato",Quantity: "1", checked: false),Ingredient(Name: "Jalapeños",Quantity: "1", checked: false),Ingredient(Name: "Crisp Lettuce",Quantity: "2", checked: false)], f: false)),(Recipe(Title: "Pizza", D: "A super delicious four cheese pizza with pepperoni", R: Float(3), I: UIImage(named: "initialBackground3")!, user: "ElItaliano", c: .Pizza, s: [Step(text: "Prepare the dow", checked : false)], i: [Ingredient(Name: "Pepperoni",Quantity: "6", checked: false),Ingredient(Name: "Four cheese",Quantity: "300g", checked: false),Ingredient(Name: "Tomatoes",Quantity: "2", checked: false),Ingredient(Name: "Olives",Quantity: "10", checked: false),Ingredient(Name: "Dow",Quantity: "300g", checked: false)], f: false)) ]
    
    static private var instance : TableOfRecipes? = nil
    
    static func getInstance() -> TableOfRecipes{
        if(instance == nil){
            instance = TableOfRecipes()
        }
        return instance!
    }
    
    func AddRecipe(recipe : Recipe){
        Recipes.append(recipe)
    }
    
    func GetRecipe() -> [Recipe]{
        return Recipes
    }
    
    func GetFavorites() -> [Recipe]{
        var Favorites = [Recipe]()
        for i in Recipes{
            if i.Favorite{
                Favorites.append(i)
                print(i.RecetteTitle)
            }
        }
        return Favorites
    }
    
    func Favorite(index : Int){
        print("Changing Favorite")
        Recipes[index].Favorite = !Recipes[index].Favorite
    }
}
