//
//  WhoViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WhoDisplayLogic: class {
	var router: WhoRouterLogic? { get set }
}

class WhoViewController: BaseViewController {
	var interactor: WhoBusinessLogic?
	var router: WhoRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension WhoViewController: WhoDisplayLogic {
	// do someting...
}

extension WhoViewController {
	// do someting...
}

extension WhoViewController {
	// do someting...
}
