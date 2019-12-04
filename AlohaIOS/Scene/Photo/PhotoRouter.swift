//
//  PhotoRouter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.


import UIKit

protocol PhotoRouterLogic {
	// do someting...
}

class PhotoRouter: PhotoRouterLogic {	
	weak var view: PhotoViewController?
	
	init(view: PhotoViewController?) {
		self.view = view
	}
}
