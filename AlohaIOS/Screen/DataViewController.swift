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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callView(controller: "WhoViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            callView(controller: "PhotoViewController")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
