//
//  ConfirmViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class ConfirmViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        let typeUser = TypeUser()
        if(typeUser.REGISTER) {
            callNext(viewController: "EmailViewController")
            } else {
            callNext(viewController: "PhotoViewController")
        }
    }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        callNext(viewController: "WelcomeViewController")
    }
    
    @IBAction func cancelVisitWhenButtonTouchUpInside() {
        callNext(viewController: "WelcomeViewController")
    }
}
