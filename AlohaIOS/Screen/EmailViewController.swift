//
//  EmailViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class EmailViewController: BaseViewController {
    
    var page : String = ""
    
    @IBOutlet weak var emailTextField: TextFieldClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = FlowData.flowInstance.getLastPage()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callView(controller: "WelcomeViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        let emailText = emailTextField.text
        if !FormValidation.isValidEmail(email: emailText) {
            let alert = Alert.showAlertError(messageError: "Informe um email válido")
            self.present(alert, animated: true, completion: nil)
            return
        }
        //Save if email is Zupper or registered
        UserFlow.userInstance.setUserEmail(email: emailText!)
        FlowData.flowInstance.setEmailRegistered(status: verifyIfEmailIsRegistered(emailText!))
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "ObjectiveViewController")
        callView(controller: "ObjectiveViewController")
    }
    
    func verifyIfEmailIsRegistered(_ email: String) -> Bool {
        if FormValidation.isValidEmailZupper(email: email) || verifyIfEmailInApi(email: email) {
            return true
        } else { return false }
    }
    
    //Call to API
    func verifyIfEmailInApi(email: String) -> Bool{
        if email == "luizhcarminati@gmail.com" || email == "lz___@hotmail.com" {
            return true
        } else { return false }
    }
    
}
