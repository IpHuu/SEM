//
//  ProductsConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ProductsConfiguator {
    static let sharedInstance = ProductsConfiguator()
    
    func configure(viewController: ProductsViewController){
        
        let router = ProductsRouter()
        router.viewController = viewController
        
        let presenter = ProductsPresenter()
        presenter.output = viewController
        
        let interactor = ProductsInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
