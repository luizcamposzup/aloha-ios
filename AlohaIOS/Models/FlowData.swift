//
//  FlowData.swift
//  AlohaIOS
//
//  Created by zupper on 18/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct FlowData {
    
    static var flowInstance = FlowData()
    var lastPage : [String] = []
    var isEmailRegistered = false
    
    func getLastPage() -> String {
        if let last = lastPage.last {
            return last
        } else { return "" }
    }
    
    mutating func pushLastPage(ToAppendInArray: String) {
           lastPage.append(ToAppendInArray)
    }
       
    mutating func popLastPage() {
           lastPage.popLast()
    }
    
    mutating func popArrayList() {
        for lastPage in lastPage {
        popLastPage()
            print(lastPage.last as Any)
        }
    }
    
    
    mutating func setEmailRegistered(status: Bool) {
        isEmailRegistered = status
    }
    
    func getIsEmailRegistered() -> Bool {
        return isEmailRegistered
    }
    
    
}

