//
//  ListZupper.swift
//  AlohaIOS
//
//  Created by zupper on 01/01/20.
//  Copyright © 2020 Luizhcarminati. All rights reserved.
//

import Foundation

struct ListFlowData {
    
    static var listZupperInstance = ListFlowData()
    var listZupperComplete : ZupperContentResponse?
    var listZupperOnlyName = [String]()
    var listVisitor = [Visitor]()
    
    func getListZupperComplete() -> [ZupperResponse] { return listZupperComplete!.content }
    
    func getListZupperOnlyName() -> [String] { return listZupperOnlyName }
    
    func getListVisitor() -> [Visitor] { return listVisitor}
    
    mutating func setListZupperComplete(listToSet: ZupperContentResponse) { listZupperComplete = listToSet }
    
    mutating func setListZupperOnlyName(listToSet: [String]) { listZupperOnlyName = listToSet }
    
    mutating func setListVisitor(listToSet: [Visitor]) { listVisitor = listToSet }
}
