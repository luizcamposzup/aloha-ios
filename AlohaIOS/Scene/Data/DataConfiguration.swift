//
//  DataConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class DataConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = DataViewController()
        let router = DataRouter(view: controller)
        let presenter = DataPresenter(view: controller)
        let interactor = DataInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
