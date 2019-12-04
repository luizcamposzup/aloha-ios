//
//  PhotoConfiguration.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import Foundation
import UIKit

class PhotoConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = PhotoViewController()
        let router = PhotoRouter(view: controller)
        let presenter = PhotoPresenter(view: controller)
        let interactor = PhotoInteractor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
