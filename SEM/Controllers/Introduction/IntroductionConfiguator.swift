//
//  IntroductionConfiguator
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import Foundation

class IntroductionConfiguator {
    static let sharedInstance = IntroductionConfiguator()
    
    func configure(viewController: IntroductionViewController){
        
        let router = IntroductionRouter()
        router.viewController = viewController
        
        let presenter = IntroductionPresenter()
        presenter.output = viewController
        
        let interactor = IntroductionInteractor()
        interactor.output = presenter
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
