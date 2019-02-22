//
//  DevicesConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class DevicesConfiguator {
    static let sharedInstance = DevicesConfiguator()
    
    func configure(viewController: DevicesViewController){
        
        let router = DevicesRouter()
        router.viewController = viewController
        
        let presenter = DevicesPresenter()
        presenter.output = viewController
        
        let interactor = DevicesInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
