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
    
    private func requestListVisitors(emailInput: String) {
        ApiRequest.defaultRequest.getListVisitors(completion: {result in
                switch result {
                case .success(let successGetListVisitors):
                    self.callNextScene(emailUser: emailInput, statusRegister: self.verifyVisitor(emailInput, successGetListVisitors))
                    print(successGetListVisitors)
                    print("End Request Get List Visitors")
                case .failure(let error):
                    let alertError = Alert.showAlertError(messageError: "Não foi possível verificar o email")
                    self.present(alertError, animated: true)
                    print("Ocorreu um erro: \(error)")
                }
        })
    }

    private func isVerifyEmailZupperInList(_ emailToVerify: String) -> Bool {
        var result = false
        let listZupper = ListFlowData.listZupperInstance.getListZupperComplete()
        var count = 0
        for zupper in listZupper {
            count += 1
            print(count)
            if zupper.email != nil && emailToVerify.contains(zupper.email!) {
                UserFlowData.userInstance.setUserName(name: zupper.fullName)
                print("Email Zupper registered in Database")
                result = true
                break
            }
        }
        return result
    }
    
    private func verifyVisitor(_ emailIsRegistered: String, _ list: [Visitor]) -> Bool {
        var result = false
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
    
    private func processTextFieldInput() {
        guard let emailText = emailTextField.text else {
            showAlertErrorEmail()
            return
        }
        if FormValidation.isValidEmail(email: emailText) {
            if FormValidation.isDomainEmailZupper(email: emailText) {
                if binarySearchZupper(emailText) {
                    callNextScene(emailUser: emailText, statusRegister: true)
                } else {
                    showAlertErrorEmail()
                }
            } else {
                requestListVisitors(emailInput: emailText)
            }
        } else { showAlertErrorEmail() }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
    private func binarySearchZupper(_ emailToCompare: String) -> Bool {
        var result = false
        let list = ListFlowData.listZupperInstance.getListZupperComplete()
        var leftIndex = 0
        var rightIndex = list.count - 1
        var cont = 0
        
        while leftIndex <= rightIndex {
            cont += 1
            //print(cont)
            
            let middleIndex = Int(floor(Double(leftIndex + rightIndex) / 2.0))
            let middleValue = list[middleIndex].email
            //print(middleValue!)
            print(middleIndex)
            
            if middleValue != nil && middleValue!.contains(emailToCompare) {
                UserFlowData.userInstance.setUserName(name: list[middleIndex].fullName)
                result = true
                return true
            } else if emailToCompare.compare(middleValue!, options: .numeric) == .orderedDescending{
                leftIndex = middleIndex + 1
            } else if emailToCompare.compare(middleValue!, options: .numeric) == .orderedAscending {
                rightIndex = middleIndex - 1
            }
        }
        return result
    }
}
