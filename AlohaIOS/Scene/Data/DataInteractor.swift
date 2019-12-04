//
//  DataInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol DataBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class DataInteractor: DataBusinessLogic {
    var presenter: DataPresenterLogic?
    var parameters: [String: Any]?

    init(presenter: DataPresenterLogic) {
    	self.presenter = presenter
    }
}
