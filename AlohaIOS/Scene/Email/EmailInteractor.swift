//
//  EmailInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol EmailBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class EmailInteractor: EmailBusinessLogic {
    var presenter: EmailPresenterLogic?
    var parameters: [String: Any]?

    init(presenter: EmailPresenterLogic) {
    	self.presenter = presenter
    }
}
