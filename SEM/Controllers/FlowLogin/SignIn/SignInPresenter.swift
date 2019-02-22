//
//  SignInPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol SignInPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentLoginSuccess(token: TokenObject)
    func presentFetchCustomer(object: CustomerObject)
    func presentRegisterForgotPassword(otp: OTPObject)
    func presentUpdatePhoneWithLoginSocial(social: SocialInfo)
}
class SignInPresenter {
    var output: SignInPresenterOutput!
}
extension SignInPresenter: SignInInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentLoginSuccess(token: TokenObject){
        output.presentLoginSuccess(token: token)
    }
    func needPresentFetchCustomer(object: CustomerObject){
        output.presentFetchCustomer(object: object)
    }
    func needPresentRegisterForgotPassword(otp: OTPObject){
        output.presentRegisterForgotPassword(otp: otp)
    }
    func needPresentUpdatePhoneWithLoginSocial(social: SocialInfo){
        output.presentUpdatePhoneWithLoginSocial(social: social)
    }
}
