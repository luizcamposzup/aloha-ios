//
//  WelcomePresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WelcomePresenterLogic {
	// do someting...
}

class WelcomePresenter: WelcomePresenterLogic {	
	weak var view: WelcomeDisplayLogic?
	
	init(view: WelcomeDisplayLogic?) {
		self.view = view
	}
}
