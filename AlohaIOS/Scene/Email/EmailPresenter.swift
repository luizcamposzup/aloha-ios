//
//  EmailPresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol EmailPresenterLogic {
	// do someting...
}

class EmailPresenter: EmailPresenterLogic {	
	weak var view: EmailDisplayLogic?
	
	init(view: EmailDisplayLogic?) {
		self.view = view
	}
}
