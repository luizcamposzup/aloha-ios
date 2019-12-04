//
//  WelcomeViewController.swift
//  AlohaIOS
//
//  Created by zupper on 02/12/19.
//  Copyright (c) 2019 Risonaldo. All rights reserved.

import UIKit

protocol WelcomeDisplayLogic: class {
	var router: WelcomeRouterLogic? { get set }
}

class WelcomeViewController: BaseViewController {
	var interactor: WelcomeBusinessLogic?
	var router: WelcomeRouterLogic?
    
    var uiview: UIView?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        print("calledViewController")
        
        //uiview = Bundle.main.loadNibNamed("WelcomeViewController", owner: self, options: nil)
        //self.view.addSubview(self.uiview);
        
    }
//    func loadFromNib() -> Self {
//        func instantiateFromNib<T: UIViewController>() -> T {
//            return T.init(nibName: String(describing: T.self), bundle: nil)
//        }
//        return instantiateFromNib()
//    }

//    public class func fromNib(nibName: String?) -> Self {
//        func fromNibHelper<T>(nibName: String?) -> T where T : UIView {
//            let bundle = Bundle(for: T.self)
//            let name = nibName ?? String(describing: T.self)
//            return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T ?? T()
//        }
//        return fromNibHelper(nibName: nibName)
//    }
}

extension WelcomeViewController: WelcomeDisplayLogic {
	// do someting...
}

extension WelcomeViewController {
	// do someting...
}

extension WelcomeViewController {
	// do someting...
}

extension UIView {
    class func fromNib<T: BaseViewController>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

//extension UIViewController {
//    static func loadFromNib() -> Self {
//        func instantiateFromNib<T: UIViewController>() -> T {
//            return T.init(nibName: String(describing: T.self), bundle: nil)
//        }
//        return instantiateFromNib()
//    }
//}
