//
//  PhotoPresenter.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol PhotoPresenterLogic {
	// do someting...
}

class PhotoPresenter: PhotoPresenterLogic {	
	weak var view: PhotoDisplayLogic?
	
	init(view: PhotoDisplayLogic?) {
		self.view = view
	}
}
