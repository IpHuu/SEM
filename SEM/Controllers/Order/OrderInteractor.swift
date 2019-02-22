//
//  OrderInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol OrderInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentListPayment(payments: [PaymentObject])
    func needPresentCreateOrderSuccess()
}
class OrderInteractor {
    var output: OrderInteractorOutput!
    
    func getListPayment(){
        self.output.needPresentLoading(true)
        APIServices.listPayment(){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentListPayment(payments: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func createOrder(order: OrderObject){
        let isValid = validate(phone: order.phoneCustomer, name: order.nameCustomer, email: order.emailCustomer)
        if !isValid {
            output.needPresentLoading(false)
            return }
        self.output.needPresentLoading(true)
        APIServices.createOrder(order: order){
            response in
            self.output.needPresentLoading(false)
            if response.result.isSuccess {
                self.output.needPresentCreateOrderSuccess()
                return
                
            }
            self.output.needPresentError(error: response.result.error)
            
        }
    }
    
    func validate(phone: String, name: String, email: String) -> Bool {
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
}
