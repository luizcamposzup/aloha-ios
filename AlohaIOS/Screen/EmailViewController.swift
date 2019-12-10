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
    
    @IBOutlet weak var emailTextField: TextFieldClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callView(controller: "WelcomeViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        let emailText = emailTextField.text
        if FormValidation.isValidEmail(email: emailText) {
            //Verify if email is Zupper or registered
            if FormValidation.isValidEmailZupper(email: emailText ?? "") {
                //Save user as email registered
            }
            callView(controller: "ObjectiveViewController")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe um email válido")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
