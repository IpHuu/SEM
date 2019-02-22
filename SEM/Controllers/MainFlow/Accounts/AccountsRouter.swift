//
//  AccountsRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class AccountsRouter {
    weak var viewController: AccountsViewController!
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
    
    func navigateToEditProfile(){
        let profileVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: ProfileViewController.self) as! ProfileViewController
        let _ = viewController.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func navigateToSOS(){
        let SOSVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: SOSSupportViewController.self) as! SOSSupportViewController
        let _ = viewController.navigationController?.pushViewController(SOSVC, animated: true)
    }
    
    func navigateToSupport(typeInfo: Int){
        let supportVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: SupportInfoViewController.self) as! SupportInfoViewController
        supportVC.typeInfo = typeInfo
        viewController.navigationController?.pushViewController(supportVC, animated: true)
    }
    
    func navigateToListOrder(){
        let listOrderVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: OrderListViewController.self) as! OrderListViewController
        viewController.navigationController?.pushViewController(listOrderVC, animated: true)
    }
}
