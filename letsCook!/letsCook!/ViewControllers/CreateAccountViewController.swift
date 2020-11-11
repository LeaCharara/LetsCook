//
//  CreateAccountViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/15/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

protocol CreateAccountVCDelegate {
    func SendNewUser(user : User)
}

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var ErrorField: UILabel!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var VerifyPassword: UITextField!
    
    var delegate : CreateAccountVCDelegate?
    
    @IBOutlet weak var Password: UITextField!
    var Users = ListOfUsers.getInstance()
    
    var imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        ErrorField.text = ""
    }
    
    
    @IBAction func AddImageClicked(_ sender: UIButton) {
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing = true
        present(imagepicker, animated: true, completion: nil)
    }
    
    
    @IBAction func RegisterClicked(_ sender: UIButton) {
        if(VerifyUsername() && VerifyEmail() && VerifyPass() && VerifySamePass()){
            
            let user = User(u: Username.text!, e: Email.text!, p: Password.text!, i: Image.image!)
            Users.AddUser(user : user)
            ErrorField.text = "User Created"
            delegate?.SendNewUser(user: user)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func VerifyUsername () -> Bool{
        if( Users.GetUsers().contains(where: {$0.Username == Username.text!})){
            ErrorField.text = "Username already taken"
            return false
        }
        if(Username.text == ""){
            ErrorField.text = "Please write your username"
            return false
        }
        return true
    }
    func VerifyEmail () -> Bool{
        if( Users.GetUsers().contains(where: {$0.Email == Email.text!})){
            ErrorField.text = "Email already registered"
            return false
        }
        else if(Email.text == ""){
            ErrorField.text = "Please write your email"
            return false
        }
        else if((Email.text?.contains("@"))!){
            return true
        }
        ErrorField.text = "Please write a valid email"
        return false
        
        
    }
    
    func VerifyPass() -> Bool{
        let pass = Password.text
        return isPasswordValid(pass!)
    }
    func VerifySamePass() -> Bool {
        if(Password.text != VerifyPassword.text){
            ErrorField.text = "Password and Verify Password do not match"
            return false
        }
        return true
    }
    
    func isPasswordValid(_ password : String) -> Bool{

        if(password.count >= 6 && password.count <= 12){
            return true
        }
        ErrorField.text = "Your Password should be between 6 and 12 characters"
        return false
    }
}

extension CreateAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        Image.image = UIImage()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            Image.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
}
    



