//
//  EmailConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class EmailConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = EmailViewController()
        let router = EmailRouter(view: controller)
        let presenter = EmailPresenter(view: controller)
        let interactor = EmailInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
