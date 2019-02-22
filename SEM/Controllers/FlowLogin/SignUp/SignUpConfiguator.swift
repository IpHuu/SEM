//
//  SignUpConfiguator.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class SignUpConfiguator {
    static let sharedInstance = SignUpConfiguator()
    
    func configure(viewController: SignUpViewController){
        
        let router = SignUpRouter()
        router.viewController = viewController
        
        let presenter = SignUpPresenter()
        presenter.output = viewController
        
        let interactor = SignUpInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
