//
//  ConfirmOTPRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class ConfirmOTPRouter {
    weak var viewController: ConfirmOTPViewController!
    func gotoBack(){
        let _ = viewController.navigationController?.popViewController(animated: true)
    }
    func navigateToCreatePassword(object: OTPObject, customer: CustomerObject, type: Int){
        let createPassVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: CreatePasswordViewController.self) as! CreatePasswordViewController
        createPassVC.objectOTP = object
        createPassVC.customerObj = customer
        createPassVC.typeConfirm = type
        let _ = viewController.navigationController?.pushViewController(createPassVC, animated: true)
    }
    func navigateToSignUp(){
        let signUpVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignUpViewController.self) as! SignUpViewController
        
        let _ = viewController.navigationController?.pushViewController(signUpVC, animated: true)
    }
    func navigateToHome(){ // change root view
        let tabBarVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: CustomTabBarViewController.self)
        let viewControllers = [tabBarVC]
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        navVC.setViewControllers(viewControllers, animated: true)
        UIApplication.shared.keyWindow?.rootViewController = navVC
    }
}
