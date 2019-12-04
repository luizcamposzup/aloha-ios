//
//  DataRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol DataRouterLogic {
	// do someting...
}

class DataRouter: DataRouterLogic {	
	weak var view: DataViewController?
	
	init(view: DataViewController?) {
		self.view = view
	}
}
