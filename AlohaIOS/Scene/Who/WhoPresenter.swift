//
//  WhoPresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WhoPresenterLogic: class {
	// do someting...
}

class WhoPresenter: WhoPresenterLogic {	
	weak var view: WhoDisplayLogic?
	
	init(view: WhoDisplayLogic?) {
		self.view = view
	}
}
