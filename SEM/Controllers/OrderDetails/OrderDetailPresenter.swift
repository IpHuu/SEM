//
//  OrderDetailPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol OrderDetailPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentOrderDetail(object: OrderDetailObject)
}
class OrderDetailPresenter {
    var output: OrderDetailPresenterOutput!
}
extension OrderDetailPresenter: OrderDetailInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentOrderDetail(object: OrderDetailObject){
        output.presentOrderDetail(object: object)
    }
}
