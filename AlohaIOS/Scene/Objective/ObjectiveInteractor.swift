//
//  ObjectiveInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ObjectiveBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class ObjectiveInteractor: ObjectiveBusinessLogic {
    var presenter: ObjectivePresenterLogic?
    var parameters: [String: Any]?

    init(presenter: ObjectivePresenterLogic) {
    	self.presenter = presenter
    }
}
