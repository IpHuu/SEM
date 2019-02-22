//
//  SignInConfiguator.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class SignInConfiguator {
    static let sharedInstance = SignInConfiguator()
    
    func configure(viewController: SignInViewController){
        
        let router = SignInRouter()
        router.viewController = viewController
        
        let presenter = SignInPresenter()
        presenter.output = viewController
        
        let interactor = SignInInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
