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
        callView(controller: page)
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        
        if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            let name = nameTextField.text!
            let phone = phoneTextField.text!
            let company = companyTextField.text!
           
            UserFlow.userInstance.setUserName(name: name)
            UserFlow.userInstance.setUserPhone(phone: phone)
            UserFlow.userInstance.setUserCompany(company: company)
            
            FlowData.flowInstance.pushLastPage(ToAppendInArray: "PhotoViewController")
            callView(controller: "PhotoViewController")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
