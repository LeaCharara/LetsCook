//
//  SeeProfileViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/25/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

class SeeProfileViewController: UIViewController {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var Description: UILabel!
    var delegate : SendRecipeDelegate?
    var TableOfRecipeInstance = TableOfRecipes.getInstance()
    @IBOutlet weak var TableViewTitle: UILabel!
    var UserProfile : User!
    var Recipes = [Recipe]()
    @IBAction func DoneClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileImage.image = UserProfile!.Image
        Description.text = UserProfile!.Description
        navigationBar.topItem?.title = UserProfile!.Username
        TableViewTitle.text = "\(String(describing: UserProfile!.Username))'s Recipes"
        Recipes.append(contentsOf: UserProfile!.MyRecipe)
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

extension SeeProfileViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileRecipes", for: indexPath) as! ProfileRecipeTableViewCell
        let index = Recipes[indexPath.row]
        cell.RecipeImage.image = index.Image
        cell.Title.text = index.RecetteTitle
        cell.Description.text = index.Description
        cell.Rating.text = String(index.Rating)
        return cell
        
    }
    
    
    
    
}

