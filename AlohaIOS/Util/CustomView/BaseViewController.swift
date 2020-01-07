//
//  BaseViewController.swift
//  AlohaIOS
//
//  Created by zupper on 25/11/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate {

    private var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return  .lightContent }
    
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
    
    func call(viewController: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: viewController)
        show(secondVC, sender: self)
    }
    
    func nextViewController(vc: String) {
        DispatchQueue.main.async() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func backToPreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func backToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
