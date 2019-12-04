//
//  ObjectiveViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol ObjectiveDisplayLogic: class {
	var router: ObjectiveRouterLogic? { get set }
}

class ObjectiveViewController: BaseViewController {
	var interactor: ObjectiveBusinessLogic?
	var router: ObjectiveRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension ObjectiveViewController: ObjectiveDisplayLogic {
	// do someting...
}

extension ObjectiveViewController {
	// do someting...
}

extension ObjectiveViewController {
	// do someting...
}
