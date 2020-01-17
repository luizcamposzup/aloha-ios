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
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        phoneTextField.delegate = self
        companyTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        backToRootViewControllerAfterTime()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        processTextFieldInput()
    }
    
    private func registerVisitor(name: String, email: String, telephone: String, company: String, photo: String) {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Salvando dados...")
        present(alertLoading, animated: true)
        let visitorForRegister = Visitor(name: name, email: email, telephone: telephone, company: company, photo: photo)
        let registerRequest = ApiRequest()
        registerRequest.registerVisitorRequest(visitorForRegister, completion: { result in
                switch result {
                case .success( _):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alertLoading.dismiss(animated: true, completion: nil)
                        ListFlowData.listZupperInstance.setListVisitor(listToSet: [Visitor]())
                        self.nextViewController(vc: "PhotoViewController")
                    }
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alertLoading.dismiss(animated: true, completion: nil)
                        let alert = Alert.showAlertError(messageError: "Erro no salvamento dos dados")
                        self.present(alert, animated: true, completion: nil)
                        print("Visita não-registrada: \(error)")
                    }
                }
        })
    }
    
    func processTextFieldInput() {
      if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            let name = nameTextField.text!
            let phone = phoneTextField.text!
            var company = ""
            company = companyTextField.text!
            let email = UserFlowData.userInstance.getUserEmail()
            UserFlowData.userInstance.setUserName(name: name)
            UserFlowData.userInstance.setUserPhone(phone: phone)
            UserFlowData.userInstance.setUserCompany(company: company)
            registerVisitor(name: name, email: email, telephone: phone, company: company, photo: "photoURL")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
           textField.resignFirstResponder()
           phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
           textField.resignFirstResponder()
           companyTextField.becomeFirstResponder()
        } else if textField == companyTextField {
           textField.resignFirstResponder()
            processTextFieldInput()
        }
           return true
       }
    
    @objc func keyboardNotification(notification: NSNotification) {
    if let userInfo = notification.userInfo {
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.bottomMargin.constant = 200
        } else {
            self.bottomMargin.constant = endFrame!.size.height + 20
        }
       
        }
    }
}
