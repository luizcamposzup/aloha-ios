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
    var zupperName = ZupperFlowData.zupperInstance.getZupperName()
    var zupperEmail = ZupperFlowData.zupperInstance.getZupperEmail()
    var userName = UserFlowData.userInstance.getUserName()
    var userEmail = UserFlowData.userInstance.getUserEmail()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
        print(UserFlowData.userInstance.getUserName())
        print(UserFlowData.userInstance.getUserEmail())
        print(UserFlowData.userInstance.getUserPhone())
        print(UserFlowData.userInstance.getUserCompany())
        print(ZupperFlowData.zupperInstance.getZupperName())
        print(ZupperFlowData.zupperInstance.getZupperEmail())
        backToRootViewControllerAfterTime()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() { backToPreviousViewController() }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        sendNotification(name: userName, email: zupperEmail)
    }
    
    @IBAction func cancelVisitWhenButtonTouchUpInside() {
        let alert = Alert.showAlertInfo(title: "ABORTAR", messageSuccess: "Cancelar visita com \(zupperName.split(separator: " ")[0])?")
        let acceptActionYes = UIAlertAction(title: "SIM", style: .default) { action in
            self.backToRootViewController()
        }
        let acceptActionNo = UIAlertAction(title: "NÃO", style: .cancel)
        alert.addAction(acceptActionYes)
        alert.addAction(acceptActionNo)
        self.present(alert, animated: true)
    }
    
    private func setTextLabel() {
        let text = "\(userName.split(separator: " ")[0]), confirma a visita com \(zupperName.split(separator: " ")[0]) ?"
        confirmTitleTextLabel.text = text
    }
    
    private func sendNotification(name: String, email: String) {
        let alert = Alert.showAlertLoading(messageLoading: "Enviando notificação...")
        present(alert, animated: true)
        let emailForNotification = NotificationRequest(name:  name, email: email )
        let notificationRequest = ApiRequest()
            notificationRequest.notificationRequest(emailForNotification, completion: { result in
                switch result {
                case .success(let successNotification):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        alert.dismiss(animated: true, completion: nil)
                        print("Zupper notificado")
                        self.alertMessage(error: false)
                    }
                case .failure(let error):
                    alert.dismiss(animated: true, completion: nil)
                    self.alertMessage(error: true)
                    print("Ocorreu um erro: \(error)")
                }
        })
    }
    
    private func alertMessage(error: Bool) {
        var status = false
        var title: String
        var message: String
        if(error) {
            title = "CANCELADA"
            message = "Erro ao notificar \(zupperName.split(separator: " ")[0])"
        } else {
            title = "CONFIRMADA"
            message = "\(zupperName.split(separator: " ")[0]) foi notificado da sua visita. Aguarde na recepção"
        }
        let alert = Alert.showAlertInfo(title: title, messageSuccess: message)
        let acceptAction = UIAlertAction(title: "OK", style: .default) { action in
                status = true
                ZupperFlowData.zupperInstance.setZupperName(name: "")
                ZupperFlowData.zupperInstance.setZupperEmail(emailListZupper: "")
                self.backToRootViewController()
        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            if !status {
                alert.dismiss(animated: true, completion: nil)
                self.backToRootViewController()
            }
        }
    }
}
