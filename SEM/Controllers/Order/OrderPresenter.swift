//
//  OrderPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol OrderPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentListPayment(payments: [PaymentObject])
    func presentCreateOrderSuccess()
}
class OrderPresenter {
    var output: OrderPresenterOutput!
}
extension OrderPresenter: OrderInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentListPayment(payments: [PaymentObject]){
        output.presentListPayment(payments: payments)
    }
    func needPresentCreateOrderSuccess(){
        output.presentCreateOrderSuccess()
    }
}
