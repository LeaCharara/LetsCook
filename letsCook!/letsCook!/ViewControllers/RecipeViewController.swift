//
//  RecipeViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/21/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol RecipeDelegate {
    func sendNewRating(rating : Float, recipe : Recipe)
}

class RecipeViewController: UIViewController {
    
    var CurrentRecipe : Recipe?
    var rating : Float?
    var pickerView = UIPickerView()
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var DescriptionText: UILabel!
    @IBOutlet weak var IngredientTableView: UITableView!
    var delegate : RecipeDelegate?
    //ingredient identifier : IngredientCell
    //step identifier : StepCell
    
    @IBOutlet weak var RecipeTitle: UILabel!
    @IBOutlet weak var StepsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Image.image = CurrentRecipe?.Image
        DescriptionText.text = CurrentRecipe?.Description
        RecipeTitle.text = CurrentRecipe?.RecetteTitle
        IngredientTableView.reloadData()
        StepsTableView.reloadData()
        
        
    }
    
    @IBAction func RateClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Rate This Recipe", message:"\n\n\n\n", preferredStyle: .alert)
        
        pickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.addSubview(pickerView)
        pickerView.dataSource = self
        
        pickerView.delegate = self
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
            let newrating = ((self.CurrentRecipe!.Rating * Float(self.CurrentRecipe!.nbofrating )) + self.rating!)/Float(self.CurrentRecipe!.nbofrating + 1)
            print("\(newrating)" )
            self.delegate?.sendNewRating(rating: newrating, recipe: self.CurrentRecipe!)
            self.CurrentRecipe!.nbofrating += 1
        }))
        present(alert, animated: true)
    }
    
    @IBAction func DoneClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
}


extension RecipeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case IngredientTableView:
           return (CurrentRecipe?.Ingredients.count)!
            
        case StepsTableView:
            return (CurrentRecipe?.Steps.count)!
           
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case IngredientTableView:
            let ing = CurrentRecipe?.Ingredients[indexPath.row]
            let cell = IngredientTableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! RecipeIngredientTableViewCell
            cell.delegate = self
            cell.IngredientName.text = ing?.Name
            cell.Quantity.text = ing?.Quantity
            if(ing!.checked){
                cell.CheckMarkButton.setTitle("✅", for: .normal)
            }
            else{
                cell.CheckMarkButton.setTitle("⬜️", for: .normal)
            }
            return cell
        case StepsTableView:
           let step = CurrentRecipe?.Steps[indexPath.row]
           
           let cell = StepsTableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! StepsWithCheckMarkTableViewCell
           cell.delegate = self
            cell.StepText.text = step?.text
           if(step!.checked){
            cell.CheckMarkButton.setTitle("✅", for: .normal)
           }
           else{
            cell.CheckMarkButton.setTitle("⬜️", for: .normal)
            }
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    
}

extension RecipeViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let nb = [0,1,2,3,4,5]
        return String(nb[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
        case 0:
           rating = 0
        case 1:
           rating = 1
        case 2:
           rating = 2
        case 3:
            rating = 3
        case 4:
            rating = 4
        case 5:
            rating = 5
        default:
            break
        }
    }
}

extension RecipeViewController : SendRecipeDelegate, RecipeIngredientCellDelegate, StepsWithCheckMarkDelegate{
    func SendUser(user: User) {
        return
    }
    
    func SendIngredientCell(cell: RecipeIngredientTableViewCell) {
        let index = IngredientTableView.indexPath(for: cell)
        CurrentRecipe?.Ingredients[(index?.row)!].checked = !(CurrentRecipe?.Ingredients[(index?.row)!].checked)!
        IngredientTableView.reloadRows(at: [index!], with: .automatic)
    }
    
    func SendStepCell(cell: StepsWithCheckMarkTableViewCell) {
        let index = StepsTableView.indexPath(for: cell)
        CurrentRecipe?.Steps[(index?.row)!].checked = !(CurrentRecipe?.Steps[(index?.row)!].checked)!
        StepsTableView.reloadRows(at: [index!], with: .automatic)
    }
    
    func SendRecipe(recipe: Recipe) {
        print("Here")
        CurrentRecipe = recipe
    }
    
    
}

