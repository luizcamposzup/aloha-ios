//
//  ButtonClass.swift
//  AlohaIOS
//
//  Created by zupper on 25/11/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class ButtonClass: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = #colorLiteral(red: 0.6499858499, green: 0.7582921386, blue: 0.222558856, alpha: 1)
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        titleLabel?.font = UIFont(name: "DiavloBook-Regular", size: 30)
        layer.cornerRadius = frame.size.height/5
    }
}
