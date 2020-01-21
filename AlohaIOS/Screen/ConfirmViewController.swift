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
    private var zupperName = ZupperFlowData.zupperInstance.getZupperName()
    private var zupperEmail = ZupperFlowData.zupperInstance.getZupperEmail()
    private var userName = UserFlowData.userInstance.getUserName()
    private var userEmail = UserFlowData.userInstance.getUserEmail()

    override func viewDidLoad() {
        super.viewDidLoad()
        backToRootViewControllerAfterTime()
        self.setTextLabel()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        self.sendNotification(name: userName, email: zupperEmail)
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
        let alertLoading = Alert.showAlertLoading(messageLoading: "Enviando notificação...")
        present(alertLoading, animated: true)
        let emailForNotification = NotificationRequest(name:  name, email: email )
        self.requestNotification(objectNotification: emailForNotification, alert: alertLoading)
    }
    
    private func requestNotification(objectNotification: NotificationRequest, alert: UIAlertController) {
        ApiRequest.apiRequestInstance.notificationRequest(objectNotification, completion: { result in
                switch result {
                case .success( _):
                    self.resultRequestApi(statusAlert: false, alert: alert)
                case .failure( _):
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        self.resultRequestApi(statusAlert: true, alert: alert)
                    }
                }
        })
    }
    
    private func resultRequestApi(statusAlert: Bool, alert: UIAlertController) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            alert.dismiss(animated: true, completion: nil)
            self.alertMessage(error: statusAlert)
        }
    }
    
    private func alertMessage(error: Bool) {
        var status = false
        var title: String
        var message: String
        if error {
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
