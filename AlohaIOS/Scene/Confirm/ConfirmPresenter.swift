//
//  ConfirmPresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ConfirmPresenterLogic {
	// do someting...
}

class ConfirmPresenter: ConfirmPresenterLogic {	
	weak var view: ConfirmDisplayLogic?
	
	init(view: ConfirmDisplayLogic?) {
		self.view = view
	}
}
