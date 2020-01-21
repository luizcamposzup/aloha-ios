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
        backToRootViewControllerAfterTime()
        nameTextField.delegate = self
        phoneTextField.delegate = self
        companyTextField.delegate = self
        setObserverKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameTextField.becomeFirstResponder()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        processTextFieldInput()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
    }
       
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
            case nameTextField:
                 phoneTextField.becomeFirstResponder()
            case phoneTextField:
                 companyTextField.becomeFirstResponder()
            default:
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
    
    private func setObserverKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func processTextFieldInput() {
      if(FormValidation.isValidTextFrom(textField: nameTextField) && FormValidation.isValidTextFrom(textField: phoneTextField)) {
            let name = nameTextField.text!
            let phone = phoneTextField.text!
            var company = ""
            company = companyTextField.text!
            registerVisitor(name: name, telephone: phone, company: company, photo: "photoURL")
        } else {
            let alert = Alert.showAlertError(messageError: "Informe os dados necessários")
            self.present(alert, animated: true, completion: nil)
      }
    }
    
    private func registerVisitor(name: String, telephone: String, company: String, photo: String) {
        let email = UserFlowData.userInstance.getUserEmail()
        UserFlowData.userInstance.setUserName(name: name)
        UserFlowData.userInstance.setUserPhone(phone: telephone)
        UserFlowData.userInstance.setUserCompany(company: company)
        let alertLoading = Alert.showAlertLoading(messageLoading: "Salvando dados...")
        present(alertLoading, animated: true)
        let visitorForRegister = Visitor(name: name, email: email, telephone: telephone, company: company, photo: photo)
        requestRegisterVisitor(objectVisitor: visitorForRegister, alert: alertLoading)
    }
        
    private func requestRegisterVisitor(objectVisitor: Visitor, alert: UIAlertController) {
        ApiRequest.apiRequestInstance.registerVisitorRequest(objectVisitor, completion: { result in
                switch result {
                case .success( _):
                    self.resultSuccessRequestRegisterVisitor(alert: alert)
                case .failure( _):
                    self.resultFailureRequestRegisterVisitor(alert: alert)
                }
        })
    }
    
    private func resultSuccessRequestRegisterVisitor(alert: UIAlertController){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            alert.dismiss(animated: true, completion: nil)
            ListFlowData.listZupperInstance.setListVisitor(listToSet: [Visitor]())
            self.nextViewController(vc: "PhotoViewController")
        }
    }
    
    private func resultFailureRequestRegisterVisitor(alert: UIAlertController){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            alert.dismiss(animated: true, completion: nil)
            let alert = Alert.showAlertError(messageError: "Erro no salvamento dos dados")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
