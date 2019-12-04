//
//  DataPresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol DataPresenterLogic {
	// do someting...
}

class DataPresenter: DataPresenterLogic {	
	weak var view: DataDisplayLogic?
	
	init(view: DataDisplayLogic?) {
		self.view = view
	}
}
