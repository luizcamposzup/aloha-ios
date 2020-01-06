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
    var listVisitor = [Visitor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        if ListFlowData.listZupperInstance.getListVisitor().count == 0 { requestListVisitors() }
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
       backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
       processTextFieldInput()
    }
    
    private func showAlertErrorEmail() {
        let alert = Alert.showAlertError(messageError: "Informe um email válido")
        self.present(alert, animated: true, completion: nil)
    }
    
    private func requestListVisitors() {
        ApiRequest.defaultRequest.getListVisitors(completion: {result in
                switch result {
                case .success(let successGetListVisitors):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        ListFlowData.listZupperInstance.setListVisitor(listToSet: successGetListVisitors)
                        print(successGetListVisitors)
                        print("End Request Get List Visitors")
                    }
                case .failure(let error):
                    let alertError = Alert.showAlertError(messageError: "Error while checking email")
                    self.present(alertError, animated: true)
                    print("Ocorreu um erro: \(error)")
                }
        })
    }

    private func isVerifyEmailZupperInList(_ emailToVerify: String) -> Bool {
        var result = false
        let listZupper = ListFlowData.listZupperInstance.getListZupperComplete()
        for zupper in listZupper {
            if zupper.email != nil && emailToVerify.contains(zupper.email!) {
                UserFlowData.userInstance.setUserName(name: zupper.fullName)
                print("Email Zupper registered in Database")
                result = true
                break
            }
        }
        return result
    }
    
    private func verifyVisitor(_ emailIsRegistered: String) -> Bool {
        var result = false
        let list = ListFlowData.listZupperInstance.getListVisitor()
        for zupper in list {
            if emailIsRegistered.contains(zupper.email) {
                UserFlowData.userInstance.setUserName(name: zupper.name)
                print("Email Visitor registered in Database")
                result = true
                break
            }
        }
        return result
    }
    
    private func callNextScene(emailUser: String, statusRegister: Bool) {
        UserFlowData.userInstance.setUserEmail(email: emailUser)
        UserFlowData.userInstance.setEmailRegistered(status: statusRegister)
        nextViewController(vc: "ObjectiveViewController")
    }
    
    func processTextFieldInput() {
        let emailText = emailTextField.text
               if FormValidation.isValidEmail(email: emailText!) {
                   if FormValidation.isDomainEmailZupper(email: emailText!) {
                       if isVerifyEmailZupperInList(emailText!) {
                           callNextScene(emailUser: emailText!, statusRegister: true)
                       } else { showAlertErrorEmail() }
                   } else {
                       callNextScene(emailUser: emailText!, statusRegister: verifyVisitor(emailText!))
                   }
               } else { showAlertErrorEmail() }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
}
