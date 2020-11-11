//
//  ViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/12/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {

    @IBOutlet weak var UsernameField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    var Users = ListOfUsers.getInstance()

    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let UserTest = User(u: "Test", e: "Test", p: "Test", i: UIImage(named: "initialBackground2")!)
        UserTest.MyRecipe.append(Recipe(Title: "Food", D: "Nice Food", R:Float(4), I: UIImage(named: "create4")!, user: "Test", c: .BBQ, s: [Step(text: "Step", checked: false)], i: [Ingredient(Name: "Ing", Quantity: "2", checked: false)], f: false))
        Users.AddUser(user : UserTest)
        Users.AddUser(user: User(u: "ElMexicano", e: "TheOnlyMexicano@gmail.com", p: "password", i: UIImage(named: "Chef")!))
        ErrorLabel.text = ""
    }
    
    @IBAction func LogInClicked(_ sender: UIButton) {
        let username = UsernameField.text!
        let pass = PasswordField.text!
        var index : Int
        if((username != "" && pass != "") && Users.GetUsers().contains(where: {$0.Username == username})){
            index = Users.GetUsers().firstIndex(where: {$0.Username == username})!
            if(Users.GetUsers()[index].Password == pass){
                ErrorLabel.text = ""
                Users.SetCurrentUser(user: Users.GetUserByUsername(username: username))
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UITabBarController
                self.navigationController?.present(vc, animated: true)
            }
            else{
                ErrorLabel.text = "Wrong Password"
            }
        }
        else{
            ErrorLabel.text = "User does not exist"
        }
        
    }
    
    @IBAction func CreateAccountClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccountViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension LogInViewController: CreateAccountVCDelegate{
    func SendNewUser(user: User) {
        Users.AddUser(user: user)
        print("UserAdded")
    }
    
    
}


