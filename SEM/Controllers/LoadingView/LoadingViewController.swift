//
//  LoadingViewController.swift
//  SEM
//
//  Created by Ipman on 12/28/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {

    var interactor: LoadingInteractor!
    var router: LoadingRouter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check login
        if AuthenticationManager.sharedInstance.isLoggedIn{
            interactor.getMe()
        }else{
            router.navigateToHome()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        LoadingConfiguator.sharedInstance.configure(viewController: self)
    }

}
extension LoadingViewController: LoadingPresenterOutput{
    func presentLoading(_ isLoading: Bool){
        if isLoading{
            self.showLoading()
        }else{
            self.hideLoading()
        }
    }
    func presentAlert(message: String){
        self.showAlert(withMessage: message)
    }
    func presentError(error: APIError){
        self.showAlert(withMessage: error.message)
    }
    func presentFetchCustomer(object: CustomerObject){
        AuthenticationManager.sharedInstance.isLoggedIn = true
        AuthenticationManager.sharedInstance.cachedCustomer = object
        router.navigateToHome()
    }
}
