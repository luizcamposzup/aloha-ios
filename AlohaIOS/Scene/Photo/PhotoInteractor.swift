//
//  PhotoInteractor.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.


import UIKit

protocol PhotoBusinessLogic {
	var parameters: [String: Any]? { get set }
}

class PhotoInteractor: PhotoBusinessLogic {
    var presenter: PhotoPresenterLogic?
    var parameters: [String: Any]?

    init(presenter: PhotoPresenterLogic) {
    	self.presenter = presenter
    }
}
