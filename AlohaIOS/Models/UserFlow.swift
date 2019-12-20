//
//  UserFlow.swift
//  AlohaIOS
//
//  Created by zupper on 18/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct UserFlow {
    
    static var userInstance = UserFlow()
    var userName = ""
    var userEmail = ""
    var userPhone = ""
    var userCompany = ""
    
    mutating func setUserName (name : String){
        userName = name
    }
    
    mutating func setUserEmail (email : String){
        userEmail = email
    }
    
    mutating func setUserPhone (phone : String){
        userPhone = phone
    }
    
    mutating func setUserCompany (company : String){
        userCompany = company
    }
    
    func getUserName() -> String {
        return userName
    }
    
    func getUserEmail() -> String {
        return userEmail
    }
    
    func getUserPhone() -> String {
        return userPhone
    }
    
    func getUserCompany() -> String {
        return userCompany
    }
    
}
