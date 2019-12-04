//
//  DataViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol DataDisplayLogic: class {
	var router: DataRouterLogic? { get set }
}

class DataViewController: BaseViewController {
	var interactor: DataBusinessLogic?
	var router: DataRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension DataViewController: DataDisplayLogic {
	// do someting...
}

extension DataViewController {
	// do someting...
}

extension DataViewController {
	// do someting...
}
