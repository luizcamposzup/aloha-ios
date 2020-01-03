//
//  ConfirmViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class ConfirmViewController: BaseViewController {
    
    @IBOutlet weak var confirmTitleTextLabel: TitleClass!
    
    var page = FlowData.flowInstance.getLastPage()
    var zupperName = ZupperFlow.zupperInstance.getUZupperName()
    var userName = UserFlow.userInstance.getUserName()
    var userEmail = UserFlow.userInstance.getUserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
        print(UserFlow.userInstance.getUserName())
        print(UserFlow.userInstance.getUserEmail())
        print(UserFlow.userInstance.getUserPhone())
        print(UserFlow.userInstance.getUserCompany())
        print(ZupperFlow.zupperInstance.getUZupperName())
        print(ZupperFlow.zupperInstance.getZupperEmail())
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        FlowData.flowInstance.popLastPage()
        page = FlowData.flowInstance.getLastPage()
        call(viewController: page)
    }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        //Call function notification to API
        sendNotification(name: userName, email: userEmail)
    }
    
    @IBAction func cancelVisitWhenButtonTouchUpInside() {
        let alert = Alert.showAlertInfo(title: "ABORTAR", messageSuccess: "Cancelar visita \(zupperName)?")
        let acceptActionYes = UIAlertAction(title: "SIM", style: .default) { action in
            self.call(viewController: "WelcomeViewController")
        }
        let acceptActionNo = UIAlertAction(title: "NÃO", style: .cancel)
        alert.addAction(acceptActionYes)
        alert.addAction(acceptActionNo)
        self.present(alert, animated: true)
    }
    
    func setTextLabel(){
        let text = "\(userName) confirma a visita com \(zupperName)"
        confirmTitleTextLabel.text = text
    }
    
    private func sendNotification(name: String, email: String) -> Bool {
        let alert = Alert.showAlertLoading(messageLoading: "Sending notification...")
        present(alert, animated: true)
        var resultNotification = false
        let emailForNotification = NotificationRequest(name:  name, email: email )
        let notificationRequest = ApiRequest()
            notificationRequest.notificationRequest(emailForNotification, completion: { result in
                switch result {
                case .success(let successNotification):
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true, completion: nil)
                        print("Zupper notificado")
                        self.alertMessage(error: false)
                    }
                case .failure(let error):
                    alert.dismiss(animated: true, completion: nil)
                    self.alertMessage(error: true)
                    resultNotification = false
                    print("Ocorreu um erro: \(error)")
                }
        })
        return resultNotification
    }
    
    private func alertMessage(error: Bool) {
        var message: String
        if(error) {
            message = "Erro ao notificar \(zupperName)"
        } else {
            message = "\(zupperName) foi notificado da sua visita. Aguarde na recepção"
        }
        var status = false
        let alert = Alert.showAlertInfo(title: "CONFIRMADA", messageSuccess: message)
        let acceptAction = UIAlertAction(title: "OK", style: .default) { action in
                status = true
                self.call(viewController: "WelcomeViewController")
        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            if !status {
                alert.dismiss(animated: true, completion: nil)
                self.call(viewController: "WelcomeViewController")
            }
        }
    }
}
