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
        callView(controller: "EmailViewController")
    }
    
    
    @IBAction func chooseObjectiveWhenButtonTouchUpInside(_ sender: UIButton) {
        doSomethingDependingOnWhoSent(sender.tag)
    }
    
    func doSomethingDependingOnWhoSent(_ senderTag: Int) {
        callView(controller: "WhoViewController")
//         switch senderTag {
//              case 0 : callView(controller: "WhoViewController");
//              case 1 : callView(controller: "WhoViewController")
//              case 2 : callView(controller: "WhoViewController")
//              case 3 : callView(controller: "WhoViewController")
//              case 4: callView(controller: "WhoViewController")
//              case 5: callView(controller: "WhoViewController")
//              default: break
//         }
    }
    
}
