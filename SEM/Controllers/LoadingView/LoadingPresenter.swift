//
//  LoadingPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol LoadingPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentFetchCustomer(object: CustomerObject)
}
class LoadingPresenter {
    var output: LoadingPresenterOutput!
}
extension LoadingPresenter: LoadingInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentFetchCustomer(object: CustomerObject){
        output.presentFetchCustomer(object: object)
    }
}
