//
//  CreatePasswordPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol CreatePasswordPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentRegisterSuccess(objectData: CustomerObject)
    func presentForgotPasswordSuccess()
}
class CreatePasswordPresenter {
    var output: CreatePasswordPresenterOutput!
}
extension CreatePasswordPresenter: CreatePasswordInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentRegisterSuccess(objectData: CustomerObject){
        output.presentRegisterSuccess(objectData: objectData)
    }
    func needPresentForgotPasswordSuccess(){
        output.presentForgotPasswordSuccess()
    }
}
