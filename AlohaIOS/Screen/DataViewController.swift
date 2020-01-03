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
    
    var page : String = ""
    
    @IBOutlet weak var nameTextField: TextFieldClass!
    @IBOutlet weak var phoneTextField: TextFieldClass!
    @IBOutlet weak var companyTextField: TextFieldClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//    print(ZupperFlow.zupperInstance.getZupperName())
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        FlowData.flowInstance.popLastPage()
        page = FlowData.flowInstance.getLastPage()
        call(viewController: page)
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        
        if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            let name = nameTextField.text!
            let phone = phoneTextField.text!
            let company = companyTextField.text!
           
            UserFlow.userInstance.setUserName(name: name)
            UserFlow.userInstance.setUserPhone(phone: phone)
            UserFlow.userInstance.setUserCompany(company: company)
            
            let email = UserFlow.userInstance.getUserEmail()
            
            registerVisitor(name: name, email: email, telephone: phone, company: company, photo: "photoURL")
            
            FlowData.flowInstance.pushLastPage(ToAppendInArray: "ConfirmViewController")
            call(viewController: "ConfirmViewController")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func registerVisitor(name: String, email: String, telephone: String, company: String, photo: String) {
        let visitorForRegister = Visitor(name: name, email: email, telephone: telephone, company: company, photo: photo)
        let registerRequest = ApiRequest()
        registerRequest.registerVisitorRequest(visitorForRegister, completion: { result in
                switch result {
                case .success(let successNotification):
                    print("Visita registrada")
                case .failure(let error):
                    print("Visita registrada: \(error)")
                }
        })
    }
}
