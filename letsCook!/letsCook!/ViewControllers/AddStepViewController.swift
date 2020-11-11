//
//  AddStepViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/17/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol AddStepVCDelegate {
    func sendStep(step: Step)
}

class AddStepViewController: UIViewController {

    @IBOutlet weak var textstep: UITextView!
    var delegate : AddStepVCDelegate?
    
    @IBOutlet weak var ErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func SaveClicked(_ sender: UIButton) {
        guard let step = textstep.text, textstep.text != "" else{
            ErrorLabel.text = "Please write a step"
            return
        }
        delegate?.sendStep(step: Step(text: step, checked: false))
        
        
    }
    
}
