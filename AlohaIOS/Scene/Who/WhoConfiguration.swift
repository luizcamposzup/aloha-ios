//
//  WhoConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class WhoConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = WhoViewController()
        let router = WhoRouter(view: controller)
        let presenter = WhoPresenter(view: controller)
        let interactor = WhoInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
