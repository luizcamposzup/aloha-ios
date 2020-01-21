//
//  EmailViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class EmailViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: TextFieldClass!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    var listVisitor = [Visitor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToRootViewControllerAfterTime()
        emailTextField.delegate = self
        setObserverKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
    private func processTextFieldInput() {
        guard let emailText = emailTextField.text else {
            return
        }
        let email = removeSpace(fromString: emailText)
        if FormValidation.isValidEmail(email: email) {
            if FormValidation.isDomainEmailZupper(email: email) {
                verifyIfZupperExist(email)
            } else {
                verifyIfVisitorExist(email)
            }
        } else {
            showAlertErrorEmail()
        }
    }
    
    private func showAlertErrorEmail() {
        let alert = Alert.showAlertError(messageError: "Informe um email válido")
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertConection() {
        let alert = Alert.showAlertError(messageError: "Houve um problema na resposta do servidor")
        self.present(alert, animated: true, completion: nil)
    }
    
    private func verifyIfZupperExist(_ emailToSearch: String) {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Verificando email...")
        present(alertLoading, animated: true)
        requestZupper(email: emailToSearch, alert: alertLoading)
    }
    
    private func requestZupper(email: String, alert: UIAlertController) {
        ApiRequest.apiRequestInstance.getZupper(emailOrNameToSearch: email, sizeRequest: "1", completion: { result in
                switch result {
                case .success(let successGetListZuppers):
                    self.resultSuccessRequestZupper(response: successGetListZuppers, alert: alert)
                case .failure(let error):
                    self.resultFailureRequestZupper(error: error, alert: alert)
                }
        })
    }
    
    private func resultSuccessRequestZupper(response: ZupperContentResponse, alert: UIAlertController) {
        DispatchQueue.main.async {
            alert.dismiss(animated: true)
            if response.content.count > 0 {
                let zupperData = response.content[0]
                self.setDataUser(name: zupperData.fullName, email: zupperData.email!)
                self.callNextScene(statusRegister: true)
            } else {
                self.showAlertErrorEmail()
            }
        }
    }
    
    private func resultFailureRequestZupper(error: APIError, alert: UIAlertController) {
        if error == .responseProblem {
            DispatchQueue.main.async {
                alert.dismiss(animated: true)
                self.showAlertConection()
            }
        } else {
            DispatchQueue.main.async {
                alert.dismiss(animated: true)
                self.showAlertErrorEmail()
            }
        }
    }
    
    private func verifyIfVisitorExist(_ emailToSearch: String) {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Verificando email...")
        present(alertLoading, animated: true)
        requestVisitor(email: emailToSearch, alert: alertLoading)
    }
    
    private func requestVisitor(email: String, alert: UIAlertController) {
        ApiRequest.apiRequestInstance.getVisitor(emailVisitorToSearch: email, completion: {result in
                switch result {
                case .success(let successGetListVisitors):
                    self.resultSuccessRequestVisitor(response: successGetListVisitors, alert: alert)
                case .failure(let error):
                    self.resultFailureRequestVisitor(error: error, alert: alert)
                }
        })
    }
    
    private func resultSuccessRequestVisitor(response: VisitorResponse, alert: UIAlertController) {
        self.setDataUser(name: response.name, email: response.email)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            alert.dismiss(animated: true)
            self.callNextScene(statusRegister: true)
        }
    }
    
    private func resultFailureRequestVisitor(error: APIError, alert: UIAlertController) {
        if error == .responseProblem {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                alert.dismiss(animated: true)
                print("callnextscene")
                guard let email = self.emailTextField.text else {
                    return
                }
                UserFlowData.userInstance.setUserEmail(email: email)
                self.callNextScene(statusRegister: false)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                alert.dismiss(animated: true)
                let alertError = Alert.showAlertError(messageError: "Erro na verificação de email")
                self.present(alertError, animated: true)
            }
        }
    }
    
    private func setDataUser(name: String, email: String) {
        UserFlowData.userInstance.setUserName(name: name)
        UserFlowData.userInstance.setUserEmail(email: email)
    }
    
    private func callNextScene(statusRegister: Bool) {
        UserFlowData.userInstance.setEmailRegistered(status: statusRegister)
        nextViewController(vc: "ObjectiveViewController")
    }
    
    private func removeSpace(fromString: String) -> String {
        return fromString.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
}
