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
    var email = UserFlowData.userInstance.getIsEmailRegistered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    @IBAction func nameTextFieldWatch() {
        guard let nameInput = nameTextField.text else { return }
        print(nameInput.count)
        if nameInput.count == 0 {
            
        } else if nameInput.count > 2 {
            print(nameInput)
            requestGetListZuppers(wordOfName: nameInput)
        }
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        processTextFieldInput()
    }
    
    private func addDropDown(listDataZupper: [ZupperResponse]) {
        let dropDownTop = AutoComplete()
        let listToSet = filter(listToReturnZupperOnlyName: listDataZupper)
        dropDownTop.dataSource = listToSet
        dropDownTop.onTextField = nameTextField
        dropDownTop.onView = self.view
        dropDownTop.show { (name, index) in
            print("string : \(name) and Index : \(index)")
            self.nameTextField.text = name
            let email = listDataZupper[index].email
            ZupperFlowData.zupperInstance.setZupperName(name: name)
            ZupperFlowData.zupperInstance.setZupperEmail(emailListZupper: email!)
            self.nameTextField.resignFirstResponder()
        }
    }
    
    private func goToConfirmScreen() {
        nextViewController(vc: "ConfirmViewController")
    }
    
    private func goToDataScreen() {
        nextViewController(vc: "DataViewController")
    }
    
    func processTextFieldInput() {
        if FormValidation.isValidTextFrom(textField: nameTextField) && verifyIfDataZupperEmpty() {
            email == true ? goToConfirmScreen() : goToDataScreen()
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome e selecione na lista")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
    private func requestGetListZuppers(wordOfName: String) {
        ApiRequest.defaultRequest.getListZuppers(wordsOfNameToSearch: wordOfName, completion: {result in
            switch result {
                case .success(let successGetListZuppers):
                    print("End Request Get List Zupper")
                    print(successGetListZuppers)
                    ListFlowData.listZupperInstance.setListZupperComplete(listToSet: successGetListZuppers)
                    DispatchQueue.main.async {
                        self.addDropDown(listDataZupper: successGetListZuppers.content)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alertError = Alert.showAlertError(messageError: "Erro na busca do nome")
                        self.present(alertError, animated: true)
                    }
                    print("Ocorreu um erro: \(error)")
            }
        })
    }
    
    private func verifyIfDataZupperEmpty() -> Bool {
        let name = ZupperFlowData.zupperInstance.getZupperName()
        let email = ZupperFlowData.zupperInstance.getZupperEmail()
      
        return name.count > 0 && email.count > 0
    }
    
    private func filter(listToReturnZupperOnlyName: [ZupperResponse]) -> [String] {
        var listZupperOnlyName = [String]()
        for zupper in listToReturnZupperOnlyName {
            listZupperOnlyName.append(zupper.fullName)
        }
        return listZupperOnlyName
    }
}
