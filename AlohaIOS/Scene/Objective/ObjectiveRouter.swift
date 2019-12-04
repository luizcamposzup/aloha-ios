//
//  ObjectiveRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ObjectiveRouterLogic {
	// do someting...
}

class ObjectiveRouter: ObjectiveRouterLogic {	
	weak var view: ObjectiveViewController?
	
	init(view: ObjectiveViewController?) {
		self.view = view
	}
}
