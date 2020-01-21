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
    private var tableViewZuppers = AutoComplete()
    private var nameChanged = ""
    private var emailRegistered = UserFlowData.userInstance.getIsEmailRegistered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToRootViewControllerAfterTime()
        nameTextField.delegate = self
        setListTableViewZuppers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameTextField.becomeFirstResponder()
    }
    
    @IBAction func nameTextFieldWatch() {
        guard let nameInput = nameTextField.text else { return }
        if nameInput.count > 2 {
            requestZupper(wordOfName: removeDiacritcs(fromString: nameInput))
        }
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        processTextFieldInput()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    private func processTextFieldInput() {
        if(FormValidation.isValidTextFrom(textField: nameTextField) && nameChanged == nameTextField.text) {
            emailRegistered == true ? goToConfirmScreen() : goToDataScreen()
        } else {
            let alert = Alert.showAlertError(messageError:"Informe um nome e selecione-o na lista")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
    private func requestZupper(wordOfName: String) {
        ApiRequest.apiRequestInstance.getZupper(emailOrNameToSearch: wordOfName, sizeRequest: "10", completion: { result in
            switch result {
                case .success(let successZupper):
                    self.resultSuccessRequestZupper(response: successZupper)
                case .failure( _):
                    self.resultFailureRequestZupper()
            }
        })
    }
    
    private func resultSuccessRequestZupper(response: ZupperContentResponse) {
        ListFlowData.listZupperInstance.setListZupperComplete(listToSet: response)
        DispatchQueue.main.async {
            let listToSet = self.filter(listToReturnZupperOnlyName: response.content)
            self.tableViewZuppers.updateDataSource(listToSet: listToSet)
        }
    }
    
    private func resultFailureRequestZupper() {
        DispatchQueue.main.async {
            let alertError = Alert.showAlertError(messageError: "Erro na busca do nome")
            self.present(alertError, animated: true)
        }
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
