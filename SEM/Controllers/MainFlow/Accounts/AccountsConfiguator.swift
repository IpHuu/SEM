//
//  AccountsConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class AccountsConfiguator {
    static let sharedInstance = AccountsConfiguator()
    
    func configure(viewController: AccountsViewController){
        
        let router = AccountsRouter()
        router.viewController = viewController
        
        let presenter = AccountsPresenter()
        presenter.output = viewController
        
        let interactor = AccountsInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
