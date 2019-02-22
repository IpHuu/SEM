//
//  ProfileConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class ProfileConfiguator {
    static let sharedInstance = ProfileConfiguator()
    
    func configure(viewController: ProfileViewController){
        
        let router = ProfileRouter()
        router.viewController = viewController
        
        let presenter = ProfilePresenter()
        presenter.output = viewController
        
        let interactor = ProfileInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
