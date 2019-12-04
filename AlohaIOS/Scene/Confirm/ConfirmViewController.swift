//
//  ConfirmViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ConfirmDisplayLogic: class {
	var router: ConfirmRouterLogic? { get set }
}

class ConfirmViewController: BaseViewController  {
	var interactor: ConfirmBusinessLogic?
	var router: ConfirmRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension ConfirmViewController: ConfirmDisplayLogic {
	// do someting...
}

extension ConfirmViewController {
	// do someting...
}

extension ConfirmViewController {
	// do someting...
}
