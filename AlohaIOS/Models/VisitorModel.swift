//
//  User.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

struct Visitor : Codable{
    var id: Int?
    var name:String!
    var email:String!
    var telephone: String!
    var company: String?
    var photo: String?
}

struct VisitorResponse : Codable{
    var name:String!
    var email:String!
}
