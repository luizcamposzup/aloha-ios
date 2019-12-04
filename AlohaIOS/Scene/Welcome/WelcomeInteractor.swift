//
//  WelcomeInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WelcomeBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class WelcomeInteractor: WelcomeBusinessLogic {
    var presenter: WelcomePresenterLogic?
    var parameters: [String: Any]?

    init(presenter: WelcomePresenterLogic) {
    	self.presenter = presenter
    }
}
