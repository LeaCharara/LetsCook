//
//  RecettesTableViewCell.swift
//  letsCook!
//
//  Created by Lea Charara on 4/15/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol RecipeCellDelegate
{
    func sendFavoriteCell(cell : RecipeTableViewCell)
    func sendUserCell(cell : RecipeTableViewCell)
    
}

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeTitle: UILabel!
    @IBOutlet weak var RecipeDescription: UILabel!
    @IBOutlet weak var RecipeRating: UILabel!
    @IBOutlet weak var Username: UIButton!
    var delegate : RecipeCellDelegate?
    
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    
    @IBAction func FavoriteClicked(_ sender: UIButton) {
        delegate?.sendFavoriteCell(cell: self)
    }
    @IBAction func UsernameClicked(_ sender: UIButton) {
        delegate?.sendUserCell(cell: self)
    }
}


