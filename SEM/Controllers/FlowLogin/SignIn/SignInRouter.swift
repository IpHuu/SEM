//
//  SignInRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class SignInRouter {
    weak var viewController: SignInViewController!
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
    
    func navigateToSignUp(){
        let signUpVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignUpViewController.self) as! SignUpViewController
        let _ = viewController.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToSignUpWithSocial(social: SocialInfo){
        let signUpVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignUpViewController.self) as! SignUpViewController
        signUpVC.typeRegister = TypeRegister.social.rawValue
        signUpVC.social = social
        let _ = viewController.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToConfirmCodeOTP(objectOTP: OTPObject){
        let confirmVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: ConfirmOTPViewController.self) as! ConfirmOTPViewController
        confirmVC.objectOTP = objectOTP
        confirmVC.typeConfirm = TypeConfirm.forgotPassword.rawValue
        viewController.navigationController?.pushViewController(confirmVC, animated: true)
    }
}
