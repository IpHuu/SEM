//
//  SignInInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import GoogleSignIn
protocol SignInInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentLoginSuccess(token: TokenObject)
    func needPresentFetchCustomer(object: CustomerObject)
    func needPresentRegisterForgotPassword(otp: OTPObject)
    func needPresentUpdatePhoneWithLoginSocial(social: SocialInfo)
}
class SignInInteractor: NSObject {
    var output: SignInInteractorOutput!
    fileprivate var viewController: UIViewController!
    
    func loginAccount(username: String, password: String){
        output.needPresentLoading(true)
        let isValid = validate(phone: username, password: password)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.Login(username: username, password: password){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data {
                self.output.needPresentLoginSuccess(token: data)
                return
            }
            if response.result.error.code == ErrorTokenType.ERR_TOKEN_EXP.rawValue{
                MyFunctions.refreshToken(){
                    result in
                    if result {
                        self.loginAccount(username: username, password: password)
                    }
                }
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
    func validate(phone: String, password: String) -> Bool {
        let validationPhone = Validator.validate(phoneNumber: phone)
        if !validationPhone.isValid{
            output.needPresentAlert(message: validationPhone.message)
            return validationPhone.isValid
        }
        // validate password length
        let validationPassword = Validator.validate(password: password)
        if !validationPassword.isValid{
            output.needPresentAlert(message: validationPassword.message)
            return validationPassword.isValid
        }
        
        return true
    }
    func validate(phone: String) -> Bool {
        let validationPhone = Validator.validate(phoneNumber: phone)
        if !validationPhone.isValid{
            output.needPresentAlert(message: validationPhone.message)
            return validationPhone.isValid
        }
        return true
    }
    
    func registerForgotPassword(phone: String){
        self.output.needPresentLoading(true)
        let isValid = validate(phone: phone)
        
        if !isValid {
            output.needPresentLoading(false)
            return }
        APIServices.registerForgotPassword(phone: phone){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentRegisterForgotPassword(otp: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func loginWithGoogle(viewController: UIViewController){
        self.viewController = viewController
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension SignInInteractor: GIDSignInDelegate, GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        if let error = error{
            output.needPresentAlert(message: error.localizedDescription)
            return
        }
        
        if let user = user{
            let socialInfo = SocialInfo(provider: "google",
                                        id: user.userID,
                                        name: user.profile.name,
                                        email: user.profile.email,
                                        avatar: user.profile.imageURL(withDimension: 512).absoluteString,
                                        token: user.authentication.idToken)
            self.output.needPresentLoading(true)
            APIServices.loginSocial(social: socialInfo){
                response in
                self.output.needPresentLoading(false)
                if let data =  response.result.data{
                    self.output.needPresentLoginSuccess(token: data)
                    return
                }
                if response.result.error.code == "E013"{
                    self.output.needPresentUpdatePhoneWithLoginSocial(social: socialInfo)
                    return
                }
                self.output.needPresentError(error: response.result.error)
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        output.needPresentAlert(message: error.localizedDescription)
    }
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.viewController.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
