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
        if ListFlowData.listZupperInstance.getListZupperOnlyName().count == 0 { requestGetListZuppers() }
    }
    
    @IBAction func nextScreenWhenTouchUpInside(_ sender: Any) {
        nextViewController(vc: "EmailViewController")
    }
    
    private func requestGetListZuppers() {
        let alertLoading = Alert.showAlertLoading(messageLoading: "Updating Database...")
        present(alertLoading, animated: true)
        ApiRequest.defaultRequest.getListZuppers(completion: {result in
            switch result {
                case .success(let successGetListZuppers):
                    ListFlowData.listZupperInstance.setListZupperComplete(listToSet: successGetListZuppers)
                    ListFlowData.listZupperInstance.setListZupperOnlyName(listToSet: self.filter(listToReturnZupperOnlyName: successGetListZuppers))
                    DispatchQueue.main.async {
                        alertLoading.dismiss(animated: true, completion: nil)
                        let alertSuccess = Alert.showAlertAction(title: "Sucess", messageSuccess: "Database updated successfully")
                        self.present(alertSuccess, animated: true)
                        print("End Request Get List Zupper")
                    }
                case .failure(let error):
                    alertLoading.dismiss(animated: true, completion: nil)
                    let alertError = Alert.showAlertError(messageError: "Error while updating database")
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
