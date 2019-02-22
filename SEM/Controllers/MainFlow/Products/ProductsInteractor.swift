//
//  ProductsInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol ProductsInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentListGroupDevice(data: [GroupDeviceObject])
}
class ProductsInteractor {
    var output: ProductsInteractorOutput!
    func getListGroupDevice(){
        self.output.needPresentLoading(true)
        APIServices.getListGroupDevice(){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data {
                self.output.needPresentListGroupDevice(data: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
