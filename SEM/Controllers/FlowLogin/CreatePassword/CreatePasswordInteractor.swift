//
//  CreatePasswordInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol CreatePasswordInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentRegisterSuccess(objectData: CustomerObject)
    func needPresentForgotPasswordSuccess()
}
class CreatePasswordInteractor {
    var output: CreatePasswordInteractorOutput!
    
    func completionRegisterAccount(customer: CustomerObject, confirmPassword: String){
        self.output.needPresentLoading(true)
        let isValid = validate(password: customer.password, confirmPassword: confirmPassword)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.registerCustomer(customer: customer){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentRegisterSuccess(objectData: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func completionRegisterForgotPassword(otpUUID: String, password: String, confirmPassword: String){
        self.output.needPresentLoading(true)
        let isValid = validate(password: password, confirmPassword: confirmPassword)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.forgotChangePassword(otpUUID: otpUUID, password: password, confirmPassword: confirmPassword){
            resposne in
            self.output.needPresentLoading(false)
            if resposne.result.isSuccess {
                self.output.needPresentForgotPasswordSuccess()
                return
            }
            self.output.needPresentError(error: resposne.result.error)
        }
    }
    
    func validate(password: String, confirmPassword: String) -> Bool {
        let validationPassword = Validator.validate(password: password)
        if !validationPassword.isValid {
            output.needPresentAlert(message: validationPassword.message)
            return validationPassword.isValid
        }
        
        let validationConfirmPass = Validator.validate(confirmPassword: confirmPassword, password: password)
        if !validationConfirmPass.isValid{
            output.needPresentAlert(message: validationConfirmPass.message)
            return validationConfirmPass.isValid
        }
        
        
        return true
    }
}
