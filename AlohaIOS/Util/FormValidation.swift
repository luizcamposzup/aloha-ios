//
//  FormValidationWorker.swift
//  AlohaIOS
//
//  Created by zupper on 03/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation

class FormValidation {
    
    private func isValidPassword(password:String?) -> Bool {
      guard let password = password else { return false }
      return password != ""
    }
    
    private func isValidEmail(email:String?) -> Bool {
      guard let email = email else { return false }
      return validation(with: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", value: email)
    }
    
    private func validation(with regex:String, value:String) -> Bool {
      let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
      return predicate.evaluate(with: value)
    }
}
