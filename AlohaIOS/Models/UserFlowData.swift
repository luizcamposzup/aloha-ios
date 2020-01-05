//
//  UserFlow.swift
//  AlohaIOS
//
//  Created by zupper on 18/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct UserFlowData {
    
    static var userInstance = UserFlowData()
    var isEmailRegistered = false
    var resgisteredUser = false
    var userName = ""
    var userEmail = ""
    var userPhone = ""
    var userCompany = ""
    
    func getIsEmailRegistered() -> Bool { return isEmailRegistered }
    
    func getResgisteredUser() -> Bool { return resgisteredUser }
    
    func getUserName() -> String { return userName }
    
    func getUserEmail() -> String { return userEmail }
    
    func getUserPhone() -> String { return userPhone }
    
    func getUserCompany() -> String { return userCompany }
    
    mutating func setResgisteredUser (user : Bool) { resgisteredUser = user }
    
    mutating func setUserName (name : String) { userName = name }
    
    mutating func setUserEmail (email : String) { userEmail = email }
    
    mutating func setUserPhone (phone : String) { userPhone = phone }
    
    mutating func setUserCompany (company : String) { userCompany = company }
    
    mutating func setEmailRegistered(status: Bool) {
        isEmailRegistered = status
        setResgisteredUser(user: status)
    }
}
