//
//  TableOrderListConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class TableOrderListConfiguator {
    static let sharedInstance = TableOrderListConfiguator()
    
    func configure(viewController: TableOrderListController){
        
        let router = TableOrderListRouter()
        router.viewController = viewController
        
        let presenter = TableOrderListPresenter()
        presenter.output = viewController
        
        let interactor = TableOrderListInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
