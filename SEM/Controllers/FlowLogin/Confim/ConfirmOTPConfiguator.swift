//
//  ConfirmOTPConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ConfirmOTPConfiguator {
    static let sharedInstance = ConfirmOTPConfiguator()
    
    func configure(viewController: ConfirmOTPViewController){
        
        let router = ConfirmOTPRouter()
        router.viewController = viewController
        
        let presenter = ConfirmOTPPresenter()
        presenter.output = viewController
        
        let interactor = ConfirmOTPInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
