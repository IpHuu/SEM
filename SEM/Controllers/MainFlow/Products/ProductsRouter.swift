//
//  ProductsRouter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class ProductsRouter {
    weak var viewController: ProductsViewController!
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
    
    func navigateToProductDetails(){
        let productDetailsVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: ProductDetailsViewController.self) as! ProductDetailsViewController
        viewController.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func navigateToLisDeviceByGroupID(groupID: GroupDeviceObject){
        let listDeviceVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: ListProductViewController.self) as! ListProductViewController
        
        listDeviceVC.groupID = groupID
        viewController.navigationController?.pushViewController(listDeviceVC, animated: true)
    }
    func navigateToCart(){
        let cartVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: CartsViewController.self) as! CartsViewController
        let _ = viewController.navigationController?.pushViewController(cartVC, animated: true)
    }
}
