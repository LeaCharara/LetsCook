//
//  Users.swift
//  letsCook!
//
//  Created by Lea Charara on 4/25/19.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation

class ListOfUsers {
    
    private var Users = [User]()
    private var CurrentUser : User?
    
    static private var instance : ListOfUsers? = nil
    
    static public func getInstance() -> ListOfUsers{
        if(instance == nil){
            instance = ListOfUsers()
        }
        return instance!
    }
    
    func AddUser(user:User){
        Users.append(user)
    }
    
    func SetCurrentUser (user : User){
        CurrentUser = user
    }
    
    func GetUsers () -> [User]{
        return Users
    }
}
