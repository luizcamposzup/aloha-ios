//
//  WelcomeViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateListZupper()
    }
    
    @IBAction func nextScreenWhenTouchUpInside(_ sender: Any) {
        nextViewController(vc: "EmailViewController")
    }
    
    private func updateListZupper() {
        if ListFlowData.listZupperInstance.getListZupperOnlyName().count == 0 {
            requestGetListZuppers()
        }
    }
    
    private func requestGetListZuppers() {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Atualizando base de dados...")
        present(alertLoading, animated: true)
        ApiRequest.defaultRequest.getListZuppers(completion: {result in
            switch result {
                case .success(let successGetListZuppers):
                    ListFlowData.listZupperInstance.setListZupperComplete(listToSet: successGetListZuppers)
                    ListFlowData.listZupperInstance.setListZupperOnlyName(listToSet: self.filter(listToReturnZupperOnlyName: successGetListZuppers))
                    DispatchQueue.main.async {
                        alertLoading.dismiss(animated: true, completion: nil)
                        let alertSuccess = Alert.showAlertAction(title: "Sucesso", messageSuccess: "Base de dados atualizada")
                        self.present(alertSuccess, animated: true)
                        print("End Request Get List Zupper")
                    }
                case .failure(let error):
                    alertLoading.dismiss(animated: true, completion: nil)
                    let alertError = Alert.showAlertError(messageError: "Não foi possível atualizar a base de dados")
                    self.present(alertError, animated: true)
                    print("Ocorreu um erro: \(error)")
            }
        })
    }
    
    private func filter(listToReturnZupperOnlyName: ZupperContentResponse) -> [String] {
        var listZupperOnlyName = [String]()
        for zupper in listToReturnZupperOnlyName.content {
            listZupperOnlyName.append(zupper.fullName)
        }
        return listZupperOnlyName
    }
}
