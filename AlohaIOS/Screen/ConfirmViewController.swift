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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callView(controller: "EmailViewController")
//        let typeUser = TypeUser()
//        if(typeUser.REGISTER) {
//            callView(controller: "EmailViewController")
//            } else {
//            callView(controller: "PhotoViewController")
//        }
    }
    
    @IBAction func confirmVisitWhenButtonTouchUpInside() {
        //Call function notification to API
        let alert = Alert.showAlertAction(title: "CONFIRMADA", messageSuccess: "Sicrano foi notificado da sua visita. Aguarde na recepção")
        let acceptAction = UIAlertAction(title: "OK", style: .default) { action in
            self.callView(controller: "WelcomeViewController")
        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
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
}
