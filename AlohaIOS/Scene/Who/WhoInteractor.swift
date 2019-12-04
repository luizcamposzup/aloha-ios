//
//  WhoInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WhoBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class WhoInteractor: WhoBusinessLogic {
    var presenter: WhoPresenterLogic?
    var parameters: [String: Any]?

    init(presenter: WhoPresenterLogic) {
    	self.presenter = presenter
    }
}
