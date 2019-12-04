//
//  GeneralRoute.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

enum GeneralRoute: Router {
    
    
    /*
     If you want passing with parameters
     you just add like this:
     
     case sample
     case sample(parameter: [String: Any])
     
     you can use: String, Int, [String: Any], etc..
    */
    
    case confirm
    case photo
    case data
    case email
    case who
    case objective
    case welcome
}

extension GeneralRoute {
    var module: UIViewController? {
        switch self {
        case .confirm:
            return ConfirmConfiguration.setup()
        case .photo:
            return PhotoConfiguration.setup()
        case .data:
            return DataConfiguration.setup()
        case .email:
            return EmailConfiguration.setup()
        case .who:
            return WhoConfiguration.setup()
        case .objective:
            return ObjectiveConfiguration.setup()
        case .welcome:
            return WelcomeConfiguration.setup()
        }
    }
}
