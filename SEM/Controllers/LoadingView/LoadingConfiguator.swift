//
//  LoadingConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class LoadingConfiguator {
    static let sharedInstance = LoadingConfiguator()
    
    func configure(viewController: LoadingViewController){
        
        let router = LoadingRouter()
        router.viewController = viewController
        
        let presenter = LoadingPresenter()
        presenter.output = viewController
        
        let interactor = LoadingInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
