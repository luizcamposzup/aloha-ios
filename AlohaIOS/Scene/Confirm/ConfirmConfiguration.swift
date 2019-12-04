//
//  ConfirmConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class ConfirmConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = ConfirmViewController()
        let router = ConfirmRouter(view: controller)
        let presenter = ConfirmPresenter(view: controller)
        let interactor = ConfirmInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
