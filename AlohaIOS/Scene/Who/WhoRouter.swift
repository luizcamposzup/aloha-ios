//
//  WhoRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WhoRouterLogic {
	// do someting...
}

class WhoRouter: WhoRouterLogic {	
	weak var view: WhoViewController?
	
	init(view: WhoViewController?) {
		self.view = view
	}
}
