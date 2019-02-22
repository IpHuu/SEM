//
//  OrderDetailConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class OrderDetailConfiguator {
    static let sharedInstance = OrderDetailConfiguator()
    
    func configure(viewController: OrderDetailViewController){
        
        let router = OrderDetailRouter()
        router.viewController = viewController
        
        let presenter = OrderDetailPresenter()
        presenter.output = viewController
        
        let interactor = OrderDetailInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
