//
//  ConfirmRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ConfirmRouterLogic {
	// do someting...
}

class ConfirmRouter: ConfirmRouterLogic {	
	weak var view: ConfirmViewController?
	
	init(view: ConfirmViewController?) {
		self.view = view
	}
}
