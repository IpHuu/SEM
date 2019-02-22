//
//  HomeConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class HomeConfiguator {
    static let sharedInstance = HomeConfiguator()
    
    func configure(viewController: HomeViewController){
        
        let router = HomeRouter()
        router.viewController = viewController
        
        let presenter = HomePresenter()
        presenter.output = viewController
        
        let interactor = HomeInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
