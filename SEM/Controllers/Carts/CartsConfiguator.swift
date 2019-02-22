//
//  CartsConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class CartsConfiguator {
    static let sharedInstance = CartsConfiguator()
    
    func configure(viewController: CartsViewController){
        
        let router = CartsRouter()
        router.viewController = viewController
        
        let presenter = CartsPresenter()
        presenter.output = viewController
        
        let interactor = CartsInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
