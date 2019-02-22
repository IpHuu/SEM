//
//  ConfirmOTPInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol ConfirmOTPInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentConfirmOTPSuccess(otp: OTPObject)
    func needPresentRegisterSocialSuccess(token: TokenObject)
    func needPresentFetchCustomer(object: CustomerObject)
}
class ConfirmOTPInteractor {
    var output: ConfirmOTPInteractorOutput!
    
    func confirmCodeOTP(otpCode: String, otpId: Int){
        output.needPresentLoading(true)
        APIServices.registerConfirmOTP(otpID: otpId, otpCode: otpCode){
            response in
            self.output.needPresentLoading(false)
            if response.result.isSuccess{
                if let data = response.result.data{
                    self.output.needPresentConfirmOTPSuccess(otp: data)
                    return
                }
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func registerSocial(social: SocialInfo, otp: OTPObject){
        output.needPresentLoading(true)
        APIServices.registerSocial(social: social, otp: otp){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentRegisterSocialSuccess(token: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    func getMe(){
        self.output.needPresentLoading(true)
        APIServices.getMe(){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentFetchCustomer(object: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
