//
//  ZupperFlow.swift
//  AlohaIOS
//
//  Created by zupper on 18/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct ZupperFlow {
    
    static var zupperInstance = ZupperFlow()
    var zupperName = ""
    var zupperEmail = ""
    
    mutating func setZupperName (name : String){
        zupperName = name
    }
       
    mutating func setZupperEmail (email : String){
        zupperEmail = email
    }
       
    func getUZupperName() -> String {
        return zupperName
    }
       
    func getZupperEmail() -> String {
        return zupperEmail
    }
}
