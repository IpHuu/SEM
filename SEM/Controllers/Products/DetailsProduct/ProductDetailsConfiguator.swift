//
//  ProductDetailsConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ProductDetailsConfiguator {
    static let sharedInstance = ProductDetailsConfiguator()
    
    func configure(viewController: ProductDetailsViewController){
        
        let router = ProductDetailsRouter()
        router.viewController = viewController
        
        let presenter = ProductDetailsPresenter()
        presenter.output = viewController
        
        let interactor = ProductDetailsInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
