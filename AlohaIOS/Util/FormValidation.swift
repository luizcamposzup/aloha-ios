//
//  FormValidation.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit

class FormValidation {
    
    static func isValidEmail(email:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidEmailZupper(email: String) -> Bool {
        return email.contains("@zup.com.br")
    }
    
    static func validation(with regex:String, value:String) -> Bool {
      let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
      return predicate.evaluate(with: value)
    }
    
    static func isValidTextFrom(textField: UITextField) -> Bool {
        let textReceivedFromTextField: String! = textField.text
        return !textReceivedFromTextField.isEmpty
    }
    
    
}
