//
//  Zupper.swift
//  AlohaIOS
//
//  Created by zupper on 01/01/20.
//  Copyright © 2020 Luizhcarminati. All rights reserved.
//

import Foundation

struct ZupperContentResponse: Codable {
    let content : [ZupperResponse]
}

struct ZupperResponse: Codable {
    let fullName : String
    let email : String?
}
