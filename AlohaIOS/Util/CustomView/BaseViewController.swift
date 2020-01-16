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
    
    func nextViewController(vc: String) {
        DispatchQueue.main.async {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func backToPreviousViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func backToRootViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func backToRootViewControllerAfterTime() {
        DispatchQueue.main.asyncAfter(deadline: .now()+120) {
            self.backToRootViewController()
        }
    }
}
