//
//  ObjectivePresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ObjectivePresenterLogic {
	// do someting...
}

class ObjectivePresenter: ObjectivePresenterLogic {	
	weak var view: ObjectiveDisplayLogic?
	
	init(view: ObjectiveDisplayLogic?) {
		self.view = view
	}
}
