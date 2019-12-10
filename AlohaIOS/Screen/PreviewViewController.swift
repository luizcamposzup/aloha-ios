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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func noButton(_ sender: Any) {
        callNext(viewController: "PhotoViewController")
    }
    
    @IBAction func yesButton(_ sender: Any) {
        callNext(viewController: "ConfirmViewController")
    }
    
    func setupPhotoPreviewLayer(){
     
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = self.photo.frame.width / 30.0
        
    }
    
}
