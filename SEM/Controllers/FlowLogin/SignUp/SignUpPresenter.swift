//
//  SignUpPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol SignUpPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentRegisterSendCodeOTP(object: OTPObject)
    func presentRegisterSendCodeOTPWithSocial(object: OTPObject)
}
class SignUpPresenter {
    var output: SignUpPresenterOutput!
}
extension SignUpPresenter: SignUpInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentRegisterSendCodeOTP(object: OTPObject){
        output.presentRegisterSendCodeOTP(object: object)
    }
    func needPresentRegisterSendCodeOTPWithSocial(object: OTPObject){
        output.presentRegisterSendCodeOTPWithSocial(object: object)
    }
}
