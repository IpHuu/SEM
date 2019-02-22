//
//  OrderRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class OrderRouter {
    weak var viewController: OrderViewController!
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
}
