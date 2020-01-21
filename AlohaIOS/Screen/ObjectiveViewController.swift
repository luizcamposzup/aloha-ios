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
    
    private var email = UserFlowData.userInstance.getIsEmailRegistered()
    private var userName = UserFlowData.userInstance.getUserName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
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
    }
    
    private func setTextLabel() {
        if email == true {
            let text = "Hey \(userName.split(separator: " ")[0]), então você já é de casa."
            let subText = "Qual sua missão hoje?"
            titleTextLabel.text = text
            subTitleTextLabel.text = subText
        }
    }
}
