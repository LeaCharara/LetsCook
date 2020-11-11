//
//  RecipeIngredientTableViewCell.swift
//  letsCook!
//
//  Created by Lea Charara on 4/21/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol RecipeIngredientCellDelegate {
    func SendIngredientCell (cell : RecipeIngredientTableViewCell)
}

class RecipeIngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var Quantity: UILabel!
    
    @IBOutlet weak var IngredientName: UILabel!
    
    var delegate : RecipeIngredientCellDelegate?
    
    @IBOutlet weak var CheckMarkButton: UIButton!
    @IBAction func CheckMarkButtonClicked(_ sender: UIButton) {
        delegate?.SendIngredientCell(cell: self)
    }
}
