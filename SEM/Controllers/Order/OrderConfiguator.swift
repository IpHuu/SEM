//
//  OrderConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class OrderConfiguator {
    static let sharedInstance = OrderConfiguator()
    
    func configure(viewController: OrderViewController){
        
        let router = OrderRouter()
        router.viewController = viewController
        
        let presenter = OrderPresenter()
        presenter.output = viewController
        
        let interactor = OrderInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
