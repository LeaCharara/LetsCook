//
//  Recette.swift
//  letsCook!
//
//  Created by Lea Charara on 4/15/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation
import UIKit

class Recipe
{
    var Username : String
    var RecetteTitle : String
    var Description : String
    var Ingredients = [Ingredient]()
    var Steps = [Step]()
    var Rating : Float
    var Image : UIImage
    var Favorite : Bool
    var Category : Category
    var nbofrating = 0
    
    init(Title : String,D: String, R: Float,I : UIImage, user : String, c : Category, s: [Step], i: [Ingredient], f : Bool)
    {
        RecetteTitle = Title
        Description = D
        Rating = R
        Image = I
        Username = user
        Category = c
        Steps = s
        Ingredients = i
        Favorite = f
        nbofrating = 1
    }
    
    func Equals (r : Recipe) -> Bool
    {
        if(RecetteTitle == r.RecetteTitle &&
            Description == r.Description &&
            Username == r.Username &&
            Category == r.Category){
            return true
        }
        return false
    }
    
    
}
