//
//  ZupperFlow.swift
//  AlohaIOS
//
//  Created by zupper on 18/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct ZupperFlowData {
    
    static var zupperInstance = ZupperFlowData()
    var zupperName = ""
    var zupperEmail = ""
    var zupperIndexList = 0
    
    func getZupperName() -> String { return zupperName }
       
    func getZupperEmail() -> String { return zupperEmail }
    
    func getZupperIndexList() -> Int { return zupperIndexList }
    
    mutating func setZupperName (name : String) { zupperName = name }
    
    mutating func setZupperIndexList (indexToSet: Int) { zupperIndexList = indexToSet }
       
    mutating func setZupperEmail (indexListZupper : Int) {
        let list = ListFlowData.listZupperInstance.getListZupperComplete()
        zupperEmail = list[indexListZupper].email!
    }
}
