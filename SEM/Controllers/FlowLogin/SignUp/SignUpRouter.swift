//
//  SignUpRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class SignUpRouter {
    weak var viewController: SignUpViewController!
    func gotoBack(){
        let _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    func navigateToConfirmOTP(object: OTPObject, customer: CustomerObject){
        let confirmVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: ConfirmOTPViewController.self) as! ConfirmOTPViewController
        confirmVC.objectOTP = object
        confirmVC.customerObj = customer
        let _ = viewController.navigationController?.pushViewController(confirmVC, animated: true)
    }
    func navigateToConfirmOTPWithSocial(social: SocialInfo, otp: OTPObject){
        let confirmVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: ConfirmOTPViewController.self) as! ConfirmOTPViewController
        confirmVC.typeConfirm = TypeConfirm.registerSocial.rawValue
        confirmVC.social = social
        confirmVC.objectOTP = otp
        let _ = viewController.navigationController?.pushViewController(confirmVC, animated: true)
    }
    
    func navigateToSignIn(){
        let signInVC = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignInViewController.self) as! SignInViewController
        viewController.navigationController?.pushViewController(signInVC, animated: true)
    }
}
