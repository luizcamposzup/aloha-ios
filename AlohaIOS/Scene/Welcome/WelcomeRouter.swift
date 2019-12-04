//
//  WelcomeRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WelcomeRouterLogic {
	// do someting...
}

class WelcomeRouter: WelcomeRouterLogic {	
	weak var view: WelcomeViewController?
	
	init(view: WelcomeViewController?) {
		self.view = view
	}
}
