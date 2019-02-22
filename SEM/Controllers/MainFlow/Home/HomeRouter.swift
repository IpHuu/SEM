//
//  HomeRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class HomeRouter {
    weak var viewController: HomeViewController!
    func gotoBack(){
        let _ = viewController.navigationController?.popViewController(animated: true)
    }

    func navigateToSignIn(){
        let signInVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignInViewController.self) as! SignInViewController
        let _ = viewController.navigationController?.pushViewController(signInVC, animated: true)
    }
    func navigateToSignUp(){
        let signUpVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignUpViewController.self) as! SignUpViewController
        let _ = viewController.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToDevices(){
        let devicesVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: DevicesViewController.self) as! DevicesViewController
        viewController.navigationController?.pushViewController(devicesVC, animated: true)
    }
    
    func navigateToSOS(){
        let SOSVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: SOSSupportViewController.self) as! SOSSupportViewController
        let _ = viewController.navigationController?.pushViewController(SOSVC, animated: true)
    }
}
