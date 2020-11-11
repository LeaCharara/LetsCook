//
//  HomeViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/15/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

    


import UIKit

protocol SendRecipeDelegate {
    func SendRecipe (recipe : Recipe)
     func SendUser(user : User)
}



class HomeViewController: UIViewController {
    
    var TableOfRecipe = TableOfRecipes.getInstance()
    var currentUser = ListOfUsers.getInstance().GetCurrentUser()
    var Favorite = [Recipe]()
    var Recipedelegate : SendRecipeDelegate?
   
    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddRecipeSegue":
            let vc = segue.destination as! AddRecipeViewController
            vc.delegate = self
        case "ShowRecipe":
            let vc = segue.destination as! RecipeViewController
            vc.delegate = self
            Recipedelegate = vc
        default:
            break
        }
        
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableOfRecipe.GetRecipe().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = TableOfRecipe.GetRecipe()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecetteCell") as! RecipeTableViewCell
        cell.delegate = self
        cell.RecipeImage.image = index.Image
        cell.RecipeTitle.text = index.RecetteTitle
        cell.RecipeDescription.text = index.Description
        cell.RecipeRating.text = String(index.Rating)
        cell.Username.setTitle(index.Username, for: .normal)
        cell.Category.text = index.Category.rawValue
        print(index.Favorite)
        if(index.Favorite)
        {
           cell.FavoriteButton.setTitle("❤️", for: .normal)
            
         }
        
       else{
            cell.FavoriteButton.setTitle("🖤", for: .normal)

        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ResetChecked(recipe: TableOfRecipe.GetRecipe()[indexPath.row])
        Recipedelegate?.SendRecipe(recipe: TableOfRecipe.GetRecipe()[indexPath.row])
    }
}

extension HomeViewController: AddRecipeVCDelegate,RecipeCellDelegate, RecipeDelegate {
    func sendUserCell(cell: RecipeTableViewCell) {
        print("Me is here")
        let index = ListOfUsers.getInstance().GetUsers().firstIndex(where: {$0.Username == cell.Username.titleLabel?.text})
        let vc = storyboard?.instantiateViewController(withIdentifier: "SeeProfile") as! SeeProfileViewController
        vc.UserProfile = ListOfUsers.getInstance().GetUsers()[index!]
        tabBarController?.present(vc, animated: true, completion: nil)
        
    }
   
    
    func sendNewRating(rating: Float, recipe : Recipe) {
        let index = TableOfRecipe.GetRecipe().firstIndex(where: {$0.Equals(r: recipe)})
        TableOfRecipe.GetRecipe()[index!].Rating = rating
        TableView.reloadData()
    }
    
    func sendFavoriteCell(cell: RecipeTableViewCell) {
        let index = TableView.indexPath(for: cell)
        TableOfRecipe.Favorite(index: index!.row)
        if(TableOfRecipe.GetRecipe()[index!.row].Favorite)
        {
            currentUser.FavoriteRecipes.append(TableOfRecipe.GetRecipe()[index!.row])
            
        }
        TableView.reloadRows(at: [index!], with: .automatic)
    }
    
    
    
    func SendRecipe(recipe: Recipe) {
        recipe.Username = currentUser.Username
        TableOfRecipe.AddRecipe(recipe: recipe)
        TableView.reloadData()
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


