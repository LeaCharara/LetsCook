//
//  FavoriteRecipeViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/20/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit


class FavoriteRecipeViewController: UIViewController
{

    @IBOutlet weak var TableView: UITableView!
    var Recipes = [Recipe]()
    var delegate : SendRecipeDelegate?
    let user = ListOfUsers.getInstance().GetCurrentUser()
    let TableOfRecipeInstance = TableOfRecipes.getInstance()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        Recipes = user.FavoriteRecipes
        TableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowRecipe":
            let vc = segue.destination as! RecipeViewController
            vc.delegate = self
            delegate = vc
        default:
            break
        }
        
    }
    
    func ResetChecked(recipe : Recipe){
        
        for i in 0 ... recipe.Ingredients.count - 1{
            recipe.Ingredients[i].checked = false
        }
        for i in 0 ... recipe.Steps.count - 1{
            recipe.Steps[i].checked = false
        }
    }

}

extension  FavoriteRecipeViewController: UITableViewDataSource, RecipeDelegate, UITableViewDelegate{
    func sendNewRating(rating: Float, recipe: Recipe) {
        let index = TableOfRecipeInstance.GetRecipe().firstIndex(where: {$0.Equals(r: recipe)})
        TableOfRecipeInstance.GetRecipe()[index!].Rating = rating
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = TableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteTableViewCell
        let recipe = Recipes[indexPath.row]
        cell.FavoriteImage.image = recipe.Image
        cell.RecipeDescription.text = recipe.Description
        cell.RecipeRating.text = String(recipe.Rating)
        cell.RecipeTitle.text = recipe.RecetteTitle
        cell.Username.text = recipe.Username
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ResetChecked(recipe: Recipes[indexPath.row])
        delegate?.SendRecipe(recipe: Recipes[indexPath.row])
      }
    
    
}
