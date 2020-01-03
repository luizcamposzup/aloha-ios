//
//  ListZupper.swift
//  AlohaIOS
//
//  Created by zupper on 01/01/20.
//  Copyright © 2020 Luizhcarminati. All rights reserved.
//

import Foundation

struct ListZupper {
    static var listZupperInstance = ListZupper()
    //init(){}
    var listZupperComplete : ZupperContentResponse?
    var listZupperOnlyName = [String]()
    var indexChosenInList = 0
    
    func getListZupperComplete() -> [ZupperResponse] {
        return listZupperComplete!.content
    }
    
    func getListZupperOnlyName() -> [String] {
        return listZupperOnlyName
    }
    
    func getIndexChosenInList() -> Int {
        return indexChosenInList
    }
    
    mutating func setListZupperComplete(listToSet: ZupperContentResponse) {
        listZupperComplete = listToSet
    }
    
    mutating func setListZupperOnlyName(listToSet: [String]) {
        listZupperOnlyName = listToSet
    }
    
    mutating func setIndexChosenInList(indexToSet: Int) {
        indexChosenInList = indexToSet
    }
}
