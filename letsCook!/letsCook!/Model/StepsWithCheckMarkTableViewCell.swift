//
//  StepsWithCheckMarkTableViewCell.swift
//  letsCook!
//
//  Created by Lea Charara on 4/21/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol StepsWithCheckMarkDelegate {
    func SendStepCell(cell : StepsWithCheckMarkTableViewCell)
}

class StepsWithCheckMarkTableViewCell: UITableViewCell {

    var delegate : StepsWithCheckMarkDelegate?
    @IBOutlet weak var CheckMarkButton: UIButton!
    @IBOutlet weak var StepText: UILabel!
    @IBAction func CheckMarkButtonClicked(_ sender: UIButton) {
        delegate?.SendStepCell(cell: self)
    }
}
