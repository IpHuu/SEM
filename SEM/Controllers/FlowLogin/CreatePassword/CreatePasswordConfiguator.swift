//
//  CreatePasswordConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class CreatePasswordConfiguator {
    static let sharedInstance = CreatePasswordConfiguator()
    
    func configure(viewController: CreatePasswordViewController){
        
        let router = CreatePasswordRouter()
        router.viewController = viewController
        
        let presenter = CreatePasswordPresenter()
        presenter.output = viewController
        
        let interactor = CreatePasswordInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
