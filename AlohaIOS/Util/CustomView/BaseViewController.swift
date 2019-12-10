//
//  BaseViewController.swift
//  AlohaIOS
//
//  Created by zupper on 25/11/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        navigationController?.isNavigationBarHidden = true

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .lightContent
        
    }
    
    
    func setBackground() {
        backgroundImageView.image = UIImage(named: "Background")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints                            = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive               = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive       = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive         = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive     = true
        
    }
    
    func callView(controller: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: controller)
        show(secondVC, sender: self)
    }
}
