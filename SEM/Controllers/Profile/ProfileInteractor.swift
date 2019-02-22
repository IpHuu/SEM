//
//  ProfileInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol ProfileInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentUpdateProfileSuccess(object: CustomerObject)
}
class ProfileInteractor {
    var output: ProfileInteractorOutput!
    
    func updateProfile(avatar: UIImage, name: String,  email: String, address: String, gender: Int){
        self.output.needPresentLoading(true)
        APIServices.updateProfile(image: avatar, name: name, email: email, address: address, gender: gender){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentUpdateProfileSuccess(object: data)
                return
            }
            if response.result.error.code == ErrorTokenType.ERR_TOKEN_EXP.rawValue{
                MyFunctions.refreshToken(){
                    result in
                    if result {
                        self.updateProfile(avatar: avatar, name: name, email: email, address: address, gender: gender)
                    }
                }
                return
            }
            
            self.output.needPresentError(error: response.result.error)
            
        }
    }
    func validate(email: String) -> Bool {
        let validationEmail = Validator.validate(email: email)
        if !validationEmail.isValid{
            output.needPresentAlert(message: validationEmail.message)
            return validationEmail.isValid
        }
        return true
    }
}
