//
//  TextFieldClass.swift
//  AlohaIOS
//
//  Created by zupper on 25/11/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class TextFieldClass: MaskField {
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupTextField()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupTextField()
     }
     
     private func setupTextField() {
        let borderField : UIColor = UIColor(named: "zupGreen")!
        tintColor = UIColor.black
        textColor = UIColor(named: "zupBlue")
        font = UIFont(name: "DiavloBook-Regular", size: 20)
        backgroundColor = UIColor(named: "textBoxColor")
        layer.borderColor = borderField.cgColor
        layer.borderWidth = 3.0
        layer.cornerRadius = 15.0
        clipsToBounds = true
        let placeholder = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont = UIFont(name: "DiavloBook-Regular", size: 20)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: placeholderFont as Any])
     }
}
