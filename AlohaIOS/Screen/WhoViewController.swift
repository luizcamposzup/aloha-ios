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
        addDropDown()
    }
    
    func addDropDown(){
            let dropDownTop = AutoComplete()
            dropDownTop.dataSource = getZuppersFromAPI()
            dropDownTop.onTextField = nameTextField
            dropDownTop.onView = self.view
            dropDownTop.show { (str, index) in
                print("string : \(str) and Index : \(index)")
                self.nameTextField.text = str
                ZupperFlow.zupperInstance.setZupperName(name: str)
            }
        }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        FlowData.flowInstance.popLastPage()
        page = FlowData.flowInstance.getLastPage()
        callView(controller: page)
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
    
    func getZuppersFromAPI() -> [String] {
        var list = [String]()
        var load = Load()
        for zupper in load.loadZuppers() {
            list.append(String(zupper.name))
        }
        return list
    }
    
    func goToConfirmScreen() {
        callView(controller: "ConfirmViewController")
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "ConfirmViewController")
    }
    
    func goToDataScreen() {
        callView(controller: "DataViewController")
        FlowData.flowInstance.pushLastPage(ToAppendInArray: "DataViewController")
    }
    
    
}
