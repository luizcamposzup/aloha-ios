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
    var email = FlowData.flowInstance.getIsEmailRegistered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listZupperOnlyName = ListZupper.listZupperInstance.getListZupperOnlyName()
        addDropDown(listNameToSetInTextField: listZupperOnlyName)
    }
    
    func addDropDown(listNameToSetInTextField: [String]){
            let dropDownTop = AutoComplete()
            dropDownTop.dataSource = listNameToSetInTextField
            dropDownTop.onTextField = nameTextField
            dropDownTop.onView = self.view
            dropDownTop.show { (str, index) in
                print("string : \(str) and Index : \(index)")
                self.nameTextField.text = str
                ZupperFlow.zupperInstance.setZupperName(name: str)
                ZupperFlow.zupperInstance.setZupperIndexList(indexToSet: index)
            }
        }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        FlowData.flowInstance.popLastPage()
        page = FlowData.flowInstance.getLastPage()
        call(viewController: page)
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        if(FormValidation.isValidTextFrom(textField: nameTextField)) {
//            FlowData.flowInstance.setLastPage(lastPagee: "WhoViewController")
            email == true ? goToConfirmScreen() : goToDataScreen()
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func goToConfirmScreen() {
        call(viewController: "ConfirmViewController")
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "ConfirmViewController")
    }
    
    func goToDataScreen() {
        call(viewController: "DataViewController")
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "DataViewController")
    }
    
    
}
