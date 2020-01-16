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
    
    @IBOutlet weak var titleTextLabel: TitleClass!
    @IBOutlet weak var subTitleTextLabel: SubTitleClass!
    
    var page : String = ""
    var email = UserFlowData.userInstance.getIsEmailRegistered()
    var userName = UserFlowData.userInstance.getUserName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTextLabel()
        backToRootViewControllerAfterTime()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    
    @IBAction func chooseObjectiveWhenButtonTouchUpInside(_ sender: UIButton) {
        doSomethingDependingOnWhoSent(sender.tag)
    }
    
    private func doSomethingDependingOnWhoSent(_ senderTag: Int) {
        nextViewController(vc: "WhoViewController")
        
//         switch SomethingDependingOnWhoSent  {
//            case user == true : callView(controller: "WhoViewController");
//            case user == false callView(controller: "WhoViewController");
//              case 2 : callView(controller: "WhoViewController")
//              case 3 : callView(controller: "WhoViewController")
//              case 4: callView(controller: "WhoViewController")
//              case 5: callView(controller: "WhoViewController")
//              default: break
//         }
    }
    
    private func changeTextLabel() {
        if email == true {
            let text = "Hey \(userName.split(separator: " ")[0]), então você já é de casa."
            let subText = "Qual sua missão hoje?"
            titleTextLabel.text = text
            subTitleTextLabel.text = subText
        }
    }
}
