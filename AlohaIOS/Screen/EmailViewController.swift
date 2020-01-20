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
    var listVisitor = [Visitor]()
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        
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
    
    func processTextFieldInput() {
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
        ApiRequest.defaultRequest.getZupper(emailOrNameToSearch: emailToSearch, sizeRequest: "1", completion: { result in
                switch result {
                case .success(let successGetListZuppers):
                    print("success zupper")
                    DispatchQueue.main.async {
                        alertLoading.dismiss(animated: true, completion: nil)
                        if successGetListZuppers.content.count > 0 {
                            let zupperData = successGetListZuppers.content[0]
                            self.setDataUser(name: zupperData.fullName, email: zupperData.email!)
                            self.callNextScene(statusRegister: true)
                        } else {
                            self.showAlertErrorEmail()
                        }
                    }
                    print("End Request Get Zupper")
                case .failure(let error):
                    if error == .responseProblem {
                        DispatchQueue.main.async {
                            alertLoading.dismiss(animated: true, completion: nil)
                            self.showAlertConection()
                        }
                    } else {
                        DispatchQueue.main.async {
                            alertLoading.dismiss(animated: true, completion: nil)
                            self.showAlertErrorEmail()
                        }
                    }
                    print("Ocorreu um erro: \(error)")
                }
        })
    }
    
    private func verifyIfVisitorExist(_ emailToSearch: String) {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Verificando email...")
        present(alertLoading, animated: true)
        ApiRequest.defaultRequest.getVisitor(emailVisitorToSearch: emailToSearch, completion: {result in
                switch result {
                case .success(let successGetListVisitors):
                    print("success visitor")
                    let visitorData = successGetListVisitors
                    self.setDataUser(name: visitorData.name, email: visitorData.email)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alertLoading.dismiss(animated: true, completion: nil)
                        self.callNextScene(statusRegister: true)
                    }
                case .failure(let error):
                    if error == .responseProblem {
                        print("Visita não cadastrada")
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            alertLoading.dismiss(animated: true, completion: nil)
                            guard let email = self.emailTextField.text else {
                                return
                            }
                            UserFlowData.userInstance.setUserEmail(email: email)
                            self.callNextScene(statusRegister: false)
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            alertLoading.dismiss(animated: true, completion: nil)
                            let alertError = Alert.showAlertError(messageError: "Erro na verificação de email")
                            self.present(alertError, animated: true)
                            print("Ocorreu um erro: \(error)")
                        }
                    }
                }
        })
    }
    
    private func setDataUser(name: String, email: String) {
        UserFlowData.userInstance.setUserName(name: name)
        UserFlowData.userInstance.setUserEmail(email: email)
    }
    
    private func callNextScene(statusRegister: Bool) {
        UserFlowData.userInstance.setEmailRegistered(status: statusRegister)
        nextViewController(vc: "ObjectiveViewController")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        processTextFieldInput()
        return true
    }
    
    private func removeSpace(fromString: String) -> String {
        return fromString.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
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
