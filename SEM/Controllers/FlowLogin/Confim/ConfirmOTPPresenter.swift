//
//  ConfirmOTPPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ConfirmOTPPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentConfirmOTPSuccess(otp: OTPObject)
    func presentRegisterSocialSuccess(token: TokenObject)
    func presentFetchCustomer(object: CustomerObject)
}
class ConfirmOTPPresenter {
    var output: ConfirmOTPPresenterOutput!
}
extension ConfirmOTPPresenter: ConfirmOTPInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentConfirmOTPSuccess(otp: OTPObject){
        output.presentConfirmOTPSuccess(otp: otp)
    }
    func needPresentRegisterSocialSuccess(token: TokenObject){
        output.presentRegisterSocialSuccess(token: token)
    }
    func needPresentFetchCustomer(object: CustomerObject){
        output.presentFetchCustomer(object: object)
    }
}
