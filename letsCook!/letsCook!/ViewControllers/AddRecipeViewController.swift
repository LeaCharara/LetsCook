//
//  AddRecipeViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/17/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol AddRecipeVCDelegate {
    func SendRecipe (recipe: Recipe)
}

class AddRecipeViewController: UIViewController {
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    var steps = [Step]()
    var Ingredients = [Ingredient]()
    
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var RecipeTitle: UITextField!
    var choices = ["Appetizer","Salad","Sandwich","Burger","Pizza","Light","Platter","BBQ"]
    var pickerView = UIPickerView()
    var Category : Category = .Appetizer
    
    var delegate : AddRecipeVCDelegate?
    
    @IBOutlet weak var IngrediantTableView: UITableView!
    @IBOutlet weak var StepsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.text = ""
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddStepViewController
        vc.delegate = self
    }
    
    @IBAction func AddIngrediantClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add Ingredient", message: "Type the ingrediant name and quantity", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {textfield in textfield.placeholder = "Ingredient Name"})
        
        alert.addTextField(configurationHandler: {textfield in textfield.placeholder = "Quantity"})
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            
            guard let name = alert.textFields![0].text, let q = alert.textFields![1].text else{
            return
            }
            
            self.Ingredients.append(Ingredient(Name: name, Quantity: q,checked: false))
            self.IngrediantTableView.reloadData()
        }))
        
       
        
    }
    
    @IBAction func CancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func AddImageClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Choose a picture", message: "Photo Library or Camera", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(_) in self.showImagePicker(sourceType: .camera)}))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(_) in self.showImagePicker(sourceType: .photoLibrary)}))
        present(alert,animated: true)
    }
    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = sourceType
            imagePickerVC.allowsEditing = true
            imagePickerVC.delegate = self
            present(imagePickerVC, animated: true)
        }
    }
    @IBAction func SaveClicked(_ sender: UIButton) {
       
        if(steps.count == 0 ){
            ErrorLabel.text = "Please don't forget the ingredients"
        }
        else if(RecipeTitle.text == "" ){
            ErrorLabel.text = "Please don't forget the recipe title"
        }
        else if(Description.text == ""){
            ErrorLabel.text = "Please don't forget the recipe description"
        }
        else if( RecipeTitle.text == nil){
             ErrorLabel.text = "Please don't forget the recipe steps"
        }
        else{
        ErrorLabel.text = ""
        
        let alert = UIAlertController(title: "Choose Category", message:"\n\n\n\n", preferredStyle: .alert)
        
        pickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.addSubview(pickerView)
        pickerView.dataSource = self
        pickerView.delegate = self
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
            guard let t = self.RecipeTitle.text, let d = self.Description.text else{
                return
            }
            let recipe = Recipe(Title: t, D: d, R: 0, I: self.Image.image!, user: "", c: self.Category, s: self.steps, i: self.Ingredients , f:false)
            self.delegate?.SendRecipe(recipe: recipe)
            ListOfUsers.getInstance().GetCurrentUser().MyRecipe.append(recipe)
            self.dismiss(animated: true, completion: nil)
            
        }))
         self.present(alert,animated: true, completion: nil )
        }
    }
        
    
    
}

extension AddRecipeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == IngrediantTableView)
        { return Ingredients.count}
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case IngrediantTableView:
        cell = tableView.dequeueReusableCell(withIdentifier: "IngrediantCell")!
            cell.textLabel?.text = Ingredients[indexPath.row].Name
            cell.detailTextLabel?.text = Ingredients[indexPath.row].Quantity
        
        case StepsTableView:
           
            let cellstep = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! RecipeStepsTableViewCell
            cellstep.StepText.text = "\(indexPath.row + 1)-  \(steps[indexPath.row].text)"
          return cellstep
            
        default: break
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(tableView == IngrediantTableView){
            Ingredients.remove(at: indexPath.row)
             }
            else{
                steps.remove(at: indexPath.row)
                 }
            tableView.reloadData()
        }
        
    }
}

extension AddRecipeViewController: AddStepVCDelegate{
    func sendStep(step: Step) {
        steps.append(step)
        dismiss(animated: true, completion: nil)
        StepsTableView.reloadData()
    }
    
    
}

extension AddRecipeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func  imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage{
            Image.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddRecipeViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       print(String(row))
        switch row {
        case 0:
            
            Category = .Appetizer
        case 1 :
            Category = .Salad
        case 2 ://"Appetizer","Salad","Sandwich","Burger","Pizza","Light","Platter","BBQ"
            Category = .Sandwich
        case 3 :
           Category = .Burger
        case 4 :
           Category = .Pizza
        case 5 :
            Category = .Light
        case 6 :
            Category = .Platter
        case 7 :
            Category = .BBQ
        default:
            break
        }
        
        }
    }
    
    

