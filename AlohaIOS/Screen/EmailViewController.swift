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
    
    var page = ""
    var emailText: String?
    
    @IBOutlet weak var emailTextField: TextFieldClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = FlowData.flowInstance.getLastPage()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        call(viewController: "WelcomeViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        emailText = emailTextField.text
        if !FormValidation.isValidEmail(email: emailText) {
            let alert = Alert.showAlertError(messageError: "Informe um email válido")
            self.present(alert, animated: true, completion: nil)
            return
        }
        UserFlow.userInstance.setUserEmail(email: emailText!)
        FlowData.flowInstance.setEmailRegistered(status: verifyIfEmailIsRegistered(emailText!))
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "ObjectiveViewController")
        call(viewController: "ObjectiveViewController")
    }
    
    func verifyIfEmailIsRegistered(_ email: String) -> Bool {
        var result = false
        if (FormValidation.isValidEmailZupper(email: email)) {
            result = isVerifyEmailZupperInList(email)
        } else {
            result = requestIsEmailRegistered(email)
        }
        return result
    }
    
    private func isVerifyEmailZupperInList(_ emailToVerify: String) -> Bool {
        var result = false
        let listZupper = ListZupper.listZupperInstance.getListZupperComplete()
        for zupper in listZupper {
            if zupper.email != nil && emailToVerify.contains(zupper.email!) {
                UserFlow.userInstance.setUserName(name: zupper.fullName)
                print("Email registered in Database")
                result = true
                break
            }
        }
        return result
    }
    
    private func requestIsEmailRegistered(_ emailToVerify: String) -> Bool {
        var resultRequest = false
        
        let alertLoading = Alert.showAlertInfo(title: "Email", messageSuccess: "Checking if email is registered in database...")
        self.present(alertLoading, animated: true)
        
        ApiRequest.defaultRequest.getListVisitors(completion: {result in
                switch result {
                case .success(let successGetListVisitors):
                    resultRequest = self.verifyIf(emailIsRegistered: emailToVerify, listToVerify: successGetListVisitors)
                    DispatchQueue.main.async {
                        alertLoading.dismiss(animated: true, completion: nil)
                        print("End Request Get List Visitors")
                    }
                case .failure(let error):
                    let alertError = Alert.showAlertError(messageError: "Error while updating database")
                    self.present(alertError, animated: true)
                    print("Ocorreu um erro: \(error)")
                }
        })
        return resultRequest
    }
    
    private func verifyIf(emailIsRegistered: String, listToVerify: [Visitor]) -> Bool {
        var result = false
        for zupper in listToVerify {
            if emailIsRegistered.contains(zupper.email) {
                UserFlow.userInstance.setUserName(name: zupper.name)
                print("Email registered in Database")
                result = true
                break
            }
        }
        return result
    }
}
