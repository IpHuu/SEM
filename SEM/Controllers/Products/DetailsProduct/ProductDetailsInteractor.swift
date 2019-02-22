//
//  ProductDetailsInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol ProductDetailsInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentDetailDevice(device: DeviceObject)
}
class ProductDetailsInteractor {
    var output: ProductDetailsInteractorOutput!
    
    func getDetailDevice(deviceID: Int){
        self.output.needPresentLoading(true)
        APIServices.getDetailDevice(deviceId: deviceID){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentDetailDevice(device: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
