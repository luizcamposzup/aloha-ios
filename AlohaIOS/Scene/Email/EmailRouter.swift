//
//  EmailRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol EmailRouterLogic {
	// do someting...
}

class EmailRouter: EmailRouterLogic {	
	weak var view: EmailViewController?
	
	init(view: EmailViewController?) {
		self.view = view
	}
}
