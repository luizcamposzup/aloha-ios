//
//  PreviewViewController.swift
//  AlohaIOS
//
//  Created by zupper on 09/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class PreviewViewController: BaseViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var image : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotoPreviewLayer()
        photo.image = self.image
        backToRootViewControllerAfterTime()
    }
    
    @IBAction func noButton(_ sender: Any) {
        backToPreviousViewController()
    }
    
    @IBAction func yesButton(_ sender: Any) {
        nextViewController(vc: "ConfirmViewController")
    }
    
    private func setupPhotoPreviewLayer() {
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = self.photo.frame.width / 30.0
    }
}
