//
//  SignUpInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol SignUpInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentRegisterSendCodeOTP(object: OTPObject)
    func needPresentRegisterSendCodeOTPWithSocial(object: OTPObject)
}
class SignUpInteractor {
    var output: SignUpInteractorOutput!
    
    func registerSendCodeOTP(phone: String, name: String, email: String){
        output.needPresentLoading(true)
        let isValid = validate(phone: phone, email: email, name: name)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.registerSendCodeOTP(phone: phone){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentRegisterSendCodeOTP(object: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func registerSendCodeOTPWithSocial(phone: String){
        output.needPresentLoading(true)
        let isValid = validate(phone: phone)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.registerSendCodeOTP(phone: phone){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentRegisterSendCodeOTPWithSocial(object: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func validate(phone: String, email: String, name: String) -> Bool {
        let validationPhone = Validator.validate(phoneNumber: phone)
        if !validationPhone.isValid{
            output.needPresentAlert(message: validationPhone.message)
            return validationPhone.isValid
        }
        let validationEmail = Validator.validate(email: email)
        if !validationEmail.isValid{
            output.needPresentAlert(message: validationEmail.message)
            return validationEmail.isValid
        }
        
        if name.isEmpty {
            output.needPresentAlert(message: Language.get("MISSING_NAME_MESSAGE"))
            return false
        }
        return true
    }
    
    func validate(phone: String) -> Bool{
        let validationPhone = Validator.validate(phoneNumber: phone)
        if !validationPhone.isValid{
            output.needPresentAlert(message: validationPhone.message)
            return validationPhone.isValid
        }
        return true
    }

}
