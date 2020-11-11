//
//  User.swift
//  letsCook!
//
//  Created by Lea Charara on 4/15/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation
import UIKit

class User
{
    var Username : String
    var Email : String
    var Password : String
    var Image : UIImage
    var MyRecipe = [Recipe]()
    var FavoriteRecipes = [Recipe]()
    var Description = ""
    
    init(u : String, e: String, p : String, i : UIImage)
    {
        Username = u
        Email = e
        Password = p
        Image = i
    }
    
    func AddRecipe (recipe : Recipe){
        MyRecipe.append(recipe)
    }
    
    
}
