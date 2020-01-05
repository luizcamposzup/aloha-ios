//
//  DataViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class DataViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: TextFieldClass!
    @IBOutlet weak var phoneTextField: TextFieldClass!
    @IBOutlet weak var companyTextField: TextFieldClass!
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            let name = nameTextField.text!
            let phone = phoneTextField.text!
            var company = ""
            company = companyTextField.text!
            let email = UserFlowData.userInstance.getUserEmail()
            UserFlowData.userInstance.setUserName(name: name)
            UserFlowData.userInstance.setUserPhone(phone: phone)
            UserFlowData.userInstance.setUserCompany(company: company)
            registerVisitor(name: name, email: email, telephone: phone, company: company, photo: "photoURL")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func registerVisitor(name: String, email: String, telephone: String, company: String, photo: String) {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Saving data...")
        present(alertLoading, animated: true)
        let visitorForRegister = Visitor(name: name, email: email, telephone: telephone, company: company, photo: photo)
        let registerRequest = ApiRequest()
        registerRequest.registerVisitorRequest(visitorForRegister, completion: { result in
                switch result {
                case .success( _):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alertLoading.dismiss(animated: true, completion: nil)
                        ListFlowData.listZupperInstance.setListVisitor(listToSet: [Visitor]())
                        self.nextViewController(vc: "ConfirmViewController")
                    }
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alertLoading.dismiss(animated: true, completion: nil)
                        let alert = Alert.showAlertError(messageError: "Erro while saving data")
                        self.present(alert, animated: true, completion: nil)
                        print("Visita não-registrada: \(error)")
                    }
                }
        })
    }
}
