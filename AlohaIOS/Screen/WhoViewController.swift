//
//  WhoViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class WhoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callNext(viewController: "ObjectiveViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        
        callNext(viewController: "EmailViewController")
    }
}
