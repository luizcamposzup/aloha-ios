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
    
    var tableViewZuppers = AutoComplete()
    var nameChanged = ""
    
    @IBOutlet weak var nameTextField: TextFieldClass!
    var emailRegistered = UserFlowData.userInstance.getIsEmailRegistered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToRootViewControllerAfterTime()
        nameTextField.delegate = self
        setListTableViewZuppers()
    }
    
    @IBAction func nameTextFieldWatch() {
        guard let nameInput = nameTextField.text else { return }
        if nameInput.count > 2 {
            requestGetListZuppers(wordOfName: removeDiacritcs(fromString: nameInput))
        }
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        processTextFieldInput()
    }
    
    private func setListTableViewZuppers() {
        self.tableViewZuppers.onTextField = nameTextField
        self.tableViewZuppers.onView = self.view
        self.tableViewZuppers.show { (name, index) in
            print("string : \(name) and Index : \(index)")
            self.nameTextField.text = name
            self.nameChanged = name
            ZupperFlowData.zupperInstance.setZupperName(name: name)
            let email = ListFlowData.listZupperInstance.getListZupperComplete()[index].email
            ZupperFlowData.zupperInstance.setZupperEmail(emailListZupper: email!)
            self.nameTextField.resignFirstResponder()
        }
    }

    private func goToConfirmScreen() {
        nextViewController(vc: "ConfirmViewController")
    }
    
    private func goToDataScreen() {
        print("Name Zupper: "+ZupperFlowData.zupperInstance.getZupperName())
        print("Email Zupper: "+ZupperFlowData.zupperInstance.getZupperEmail())
        self.tableViewZuppers.removeFromSuperview()
        nextViewController(vc: "DataViewController")
    }
    
    func processTextFieldInput() {
        if(FormValidation.isValidTextFrom(textField: nameTextField) && nameChanged == nameTextField.text) {
            emailRegistered == true ? goToConfirmScreen() : goToDataScreen()
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome e selecione-o na lista")
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
        ApiRequest.defaultRequest.getZupper(emailOrNameToSearch: wordOfName, sizeRequest: "10", completion: {result in
            switch result {
                case .success(let successGetListZuppers):
                    print("End Request Get List Zupper")
                    print(successGetListZuppers)
                    ListFlowData.listZupperInstance.setListZupperComplete(listToSet: successGetListZuppers)
                    DispatchQueue.main.async {
                        let listToSet = self.filter(listToReturnZupperOnlyName: successGetListZuppers.content)
                        self.tableViewZuppers.updateDataSource(listToSet: listToSet)
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
    
    private func filter(listToReturnZupperOnlyName: [ZupperResponse]) -> [String] {
        var listZupperOnlyName = [String]()
        for zupper in listToReturnZupperOnlyName {
            listZupperOnlyName.append(zupper.fullName)
        }
        return listZupperOnlyName
    }
    
    private func removeDiacritcs(fromString: String) -> String {
        return fromString.folding(options: .diacriticInsensitive, locale: .current)
    }
}
