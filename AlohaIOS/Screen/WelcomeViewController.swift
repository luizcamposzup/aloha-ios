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
    
    @IBAction func nextScreenWhenTouchUpInside() {
        nextViewController(vc: "EmailViewController")
    }

}
