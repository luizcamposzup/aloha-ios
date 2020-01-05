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
    var page : String = ""
    var email = UserFlowData.userInstance.getIsEmailRegistered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listZupperOnlyName = ListFlowData.listZupperInstance.getListZupperOnlyName()
        addDropDown(listNameToSetInTextField: listZupperOnlyName)
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        if(FormValidation.isValidTextFrom(textField: nameTextField)) {
            email == true ? goToConfirmScreen() : goToDataScreen()
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func addDropDown(listNameToSetInTextField: [String]){
        let dropDownTop = AutoComplete()
        dropDownTop.dataSource = listNameToSetInTextField
        dropDownTop.onTextField = nameTextField
        dropDownTop.onView = self.view
        dropDownTop.show { (str, index) in
            print("string : \(str) and Index : \(index)")
            self.nameTextField.text = str
            ZupperFlowData.zupperInstance.setZupperName(name: str)
            ZupperFlowData.zupperInstance.setZupperEmail(indexListZupper: index)
        }
    }
    
    private func goToConfirmScreen() {
        nextViewController(vc: "ConfirmViewController")
    }
    
    private func goToDataScreen() {
        nextViewController(vc: "DataViewController")
    }
}
