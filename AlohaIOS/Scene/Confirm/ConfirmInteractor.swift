//
//  ConfirmInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ConfirmBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class ConfirmInteractor: ConfirmBusinessLogic {
    var presenter: ConfirmPresenterLogic?
    var parameters: [String: Any]?

    init(presenter: ConfirmPresenterLogic) {
    	self.presenter = presenter
    }
}
