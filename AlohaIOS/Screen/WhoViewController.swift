//
//  WhoViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class WhoViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: TextFieldClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callView(controller: "ObjectiveViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        if(FormValidation.isValidTextFrom(textField: nameTextField)) {
            callView(controller: "DataViewController")
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
