//
//  ObjectiveViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class ObjectiveViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callNext(viewController: "WelcomeViewController")
    }
    
    
    @IBAction func chooseObjectiveWhenButtonTouchUpInside(_ sender: UIButton) {
        doSomethingDependingOnWhoSent(sender.tag)
    }
    
    func doSomethingDependingOnWhoSent(_ senderTag: Int) {
         switch senderTag {
         case 0 : callNext(viewController: "WhoViewController"); print(senderTag)
              case 1 : callNext(viewController: "WhoViewController")
              case 2 : callNext(viewController: "WhoViewController")
              case 3 : callNext(viewController: "WhoViewController")
              case 4: callNext(viewController: "WhoViewController")
              case 5: callNext(viewController: "WhoViewController")
              default: break
         }
    }
    
}
