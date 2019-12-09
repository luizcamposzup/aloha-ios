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
  
  @discardableResult
    static func showAlertInfo(viewController: UIViewController, title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, buttonTouched:((UIAlertAction)->Void)? = nil) -> UIAlertController {
    
    let alert = Alert(title: title, message: message, preferredStyle: preferredStyle)
    viewController.present(alert, animated: true, completion: nil)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: buttonTouched)
    alert.addAction(okAction)
    
    return alert
  }
    
  @discardableResult
    static func showAlertError(viewController: ObjectiveViewController, title: String? = "Erro", message: String?, preferredStyle: UIAlertController.Style = .alert, buttonTouched:((UIAlertAction)->Void)? = nil) -> UIAlertController {
    return showAlertInfo(viewController: viewController, title: title, message: message, preferredStyle: preferredStyle, buttonTouched: buttonTouched)
  }
  
  @discardableResult
    static func showAlertSucceess(viewController: UIViewController, title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, buttonTouched:((UIAlertAction)->Void)? = nil) -> UIAlertController {
    return showAlertInfo(viewController: viewController, title: title, message: message, preferredStyle: preferredStyle, buttonTouched: buttonTouched)
  }
  
}
