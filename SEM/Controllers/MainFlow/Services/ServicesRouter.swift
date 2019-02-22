//
//  ServicesRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class ServicesRouter {
    weak var viewController: ServicesViewController!
    func gotoBack(){
        let _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    func navigateToHome(){ // change root view
        let tabBarVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: CustomTabBarViewController.self)
        let viewControllers = [tabBarVC]
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        navVC.setViewControllers(viewControllers, animated: true)
        UIApplication.shared.keyWindow?.rootViewController = navVC
    }

    func navigateToSignIn(){
        let signInVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignInViewController.self) as! SignInViewController
        let _ = viewController.navigationController?.pushViewController(signInVC, animated: true)
    }
    func navigateToSignUp(){
        let signUpVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignUpViewController.self) as! SignUpViewController
        let _ = viewController.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
