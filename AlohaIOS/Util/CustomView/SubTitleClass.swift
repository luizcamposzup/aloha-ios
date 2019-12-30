//
//  SubTitleClass.swift
//  AlohaIOS
//
//  Created by zupper on 26/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class SubTitleClass: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel() {
        textColor = UIColor.white
        textAlignment = NSTextAlignment.center
        font = UIFont(name: "DiavloBook-Regular", size: 30)
    
    }

}
