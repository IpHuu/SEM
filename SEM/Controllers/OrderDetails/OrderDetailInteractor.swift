//
//  OrderDetailInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol OrderDetailInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentOrderDetail(object: OrderDetailObject)
}
class OrderDetailInteractor {
    var output: OrderDetailInteractorOutput!
    func getOrderDetail(idOrder: Int){
        self.output.needPresentLoading(true)
        APIServices.getOrderDetail(idOrder: idOrder){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentOrderDetail(object: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
