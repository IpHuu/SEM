//
//  ListProductConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ListProductConfiguator {
    static let sharedInstance = ListProductConfiguator()
    
    func configure(viewController: ListProductViewController){
        
        let router = ListProductRouter()
        router.viewController = viewController
        
        let presenter = ListProductPresenter()
        presenter.output = viewController
        
        let interactor = ListProductInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
