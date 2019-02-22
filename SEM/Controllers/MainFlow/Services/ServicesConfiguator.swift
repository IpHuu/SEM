//
//  ServicesConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ServicesConfiguator {
    static let sharedInstance = ServicesConfiguator()
    
    func configure(viewController: ServicesViewController){
        
        let router = ServicesRouter()
        router.viewController = viewController
        
        let presenter = ServicesPresenter()
        presenter.output = viewController
        
        let interactor = ServicesInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
