//
//  EmailViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol EmailDisplayLogic: class {
	var router: EmailRouterLogic? { get set }
}

class EmailViewController: BaseViewController {
	var interactor: EmailBusinessLogic?
	var router: EmailRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension EmailViewController: EmailDisplayLogic {
	// do someting...
}

extension EmailViewController {
	// do someting...
}

extension EmailViewController {
	// do someting...
}
