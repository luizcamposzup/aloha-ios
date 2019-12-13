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
            }
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
    
    func getZuppersFromAPI() -> [String] {
        var list = [String]()
        var load = Load()
        for zupper in load.loadZuppers() {
            list.append(String(zupper.name))
        }
        return list
    }
}
