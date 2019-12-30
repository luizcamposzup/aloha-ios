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
        callView(controller: page)
//        let typeUser = TypeUser()
//        if(typeUser.REGISTER) {
//            callView(controller: "EmailViewController")
//            } else {
//            callView(controller: "PhotoViewController")
//        }
    }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        //Call function notification to API
        var status = false
        let alert = Alert.showAlertAction(title: "CONFIRMADA", messageSuccess: "Sicrano foi notificado da sua visita. Aguarde na recepção")
        let acceptAction = UIAlertAction(title: "OK", style: .default) { action in
                status = true
                self.callView(controller: "WelcomeViewController")
                                                                        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            if !status {
                alert.dismiss(animated: true, completion: nil)
                self.callView(controller: "WelcomeViewController")
            }
        }
    }
    
    @IBAction func cancelVisitWhenButtonTouchUpInside() {
        
        let alert = Alert.showAlertAction(title: "ABORTAR", messageSuccess: "Cancelar visita a Sicrano?")
        let acceptActionYes = UIAlertAction(title: "SIM", style: .default) { action in
            self.callView(controller: "WelcomeViewController")
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
    
}
