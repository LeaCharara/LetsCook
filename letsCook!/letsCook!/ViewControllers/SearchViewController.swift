//
//  SearchViewController.swift
//  letsCook!
//
//  Created by Doris Darwich on 21/04/2019.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, RecipeDelegate
{
    let TableOfRecipeInstance = TableOfRecipes.getInstance()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var filteredRecettes = [Recipe]()
    var delegate : SendRecipeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
    
    func sendNewRating(rating: Float, recipe: Recipe) {
        let index = TableOfRecipeInstance.GetRecipe().firstIndex(where: {$0.Equals(r: recipe)})
        TableOfRecipeInstance.GetRecipe()[index!].Rating = rating
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching
        {
            return filteredRecettes.count
        }
        return TableOfRecipeInstance.GetRecipe().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 480
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchTableViewCell
        let text : String!
        if isSearching
        {
            text = filteredRecettes[indexPath.row].RecetteTitle
            cell.searchDesc.text = filteredRecettes[indexPath.row].Description
            cell.searchUsername.text = filteredRecettes[indexPath.row].Username
            cell.searchRating.text = String(filteredRecettes[indexPath.row].Rating)
            cell.searchImage.image = filteredRecettes[indexPath.row].Image
        
        }
        else
        {
           
            text = TableOfRecipeInstance.GetRecipe()[indexPath.row].RecetteTitle
            cell.searchDesc.text = TableOfRecipeInstance.GetRecipe()[indexPath.row].Description
            cell.searchUsername.text = TableOfRecipeInstance.GetRecipe()[indexPath.row].Username
            cell.searchRating.text = String(TableOfRecipeInstance.GetRecipe()[indexPath.row].Rating)
            cell.searchImage.image = TableOfRecipeInstance.GetRecipe()[indexPath.row].Image
            
        }
        cell.searchTitle.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I am here")
        ResetChecked(recipe: TableOfRecipeInstance.GetRecipe()[indexPath.row])
        delegate?.SendRecipe(recipe: TableOfRecipeInstance.GetRecipe()[indexPath.row])
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == "" 
        {
            isSearching = false
            filteredRecettes = TableOfRecipeInstance.GetRecipe()
            view.endEditing(true)
            tableView.reloadData()
        }
        else
        {
            isSearching = true
            
            filteredRecettes = TableOfRecipeInstance.GetRecipe().filter({String($0.RecetteTitle.lowercased().prefix(searchBar.text!.count)) == searchBar.text?.lowercased()})
            tableView.reloadData()
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

