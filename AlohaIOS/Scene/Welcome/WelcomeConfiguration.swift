//
//  WelcomeConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class WelcomeConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = WelcomeViewController()
        let router = WelcomeRouter(view: controller)
        let presenter = WelcomePresenter(view: controller)
        let interactor = WelcomeInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
