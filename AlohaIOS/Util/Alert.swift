//
//  Alert.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class Alert: UIAlertController {
    
    static func showAlertInfo(title: String, messageSuccess: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: messageSuccess, preferredStyle: .alert)
        let buttonClose = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(buttonClose)
        return alert
    }
    
    static func showAlertAction(title: String, messageSuccess: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: messageSuccess, preferredStyle: .alert)
        return alert
    }
    
    static func showAlertError(messageError: String) -> UIAlertController{
        let alert = UIAlertController(title: "Erro", message: messageError, preferredStyle: .alert)
        let buttonClose = UIAlertAction(title: "FECHAR", style: .cancel, handler: nil)
        alert.addAction(buttonClose)
        return alert
    }
}
