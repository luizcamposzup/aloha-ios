//
//  WelcomeViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make api request here
    }
    
    @IBAction func nextScreenWhenTouchUpInside(_ sender: Any) {
        callNext(viewController: "ObjectiveViewController")
    }
}
