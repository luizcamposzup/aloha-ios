//
//  PhotoViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.


import UIKit

protocol PhotoDisplayLogic: class {
	var router: PhotoRouterLogic? { get set }
}

class PhotoViewController: BaseViewController {
	var interactor: PhotoBusinessLogic?
	var router: PhotoRouterLogic?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension PhotoViewController: PhotoDisplayLogic {
	// do someting...
}

extension PhotoViewController {
	// do someting...
}

extension PhotoViewController {
	// do someting...
}
