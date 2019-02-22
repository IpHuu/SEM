//
//  HomePresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol HomePresenterOutput {
    
}
class HomePresenter {
    var output: HomePresenterOutput!
}
extension HomePresenter: HomeInteractorOutput{
    
}
