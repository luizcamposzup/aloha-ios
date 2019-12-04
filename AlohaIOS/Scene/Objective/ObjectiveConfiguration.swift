//
//  ObjectiveConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class ObjectiveConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = ObjectiveViewController()
        let router = ObjectiveRouter(view: controller)
        let presenter = ObjectivePresenter(view: controller)
        let interactor = ObjectiveInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
