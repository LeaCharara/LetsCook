//
//  MyProfileViewController.swift
//  letsCook!
//
//  Created by Lea Charara on 4/26/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var ProfileUsername: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var Rating: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    var CurrentUser = ListOfUsers.getInstance().GetCurrentUser()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileImage.image = CurrentUser.Image
        ProfileUsername.text = CurrentUser.Username
        Email.text = CurrentUser.Email
        Description.text = CurrentUser.Description
        var x = Float()
        if(CurrentUser.MyRecipe.count == 0){
            x = 0
            Rating.text = String("No ratings yet")
            return
        }
        for i in CurrentUser.MyRecipe{
            x += i.Rating
        }
        Rating.text = String(x/Float(CurrentUser.MyRecipe.count))
    }
    

    @IBAction func EditDescription(_ sender: Any) {
        let alert = UIAlertController(title: "Write Description", message: "Write Your New Description Here", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {textfield in textfield.placeholder = "Description"})
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            
            guard let desc = alert.textFields![0].text else{
                return
            }
            self.Description.text = desc
            self.CurrentUser.Description = desc
        }))
        present(alert, animated: true)
    }
    
    @IBAction func SignOutClicked(_ sender: Any) {
        let index = ListOfUsers.getInstance().GetUsers().firstIndex(where: {$0.Username == CurrentUser.Username})
        ListOfUsers.getInstance().ReplaceUser(index: index!, user: CurrentUser)
        ListOfUsers.getInstance().SetCurrentUser(user: nil)
        
    }
    
}
