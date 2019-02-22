//
//  ProductDetailsPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ProductDetailsPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentDetailDevice(device: DeviceObject)
}
class ProductDetailsPresenter {
    var output: ProductDetailsPresenterOutput!
}
extension ProductDetailsPresenter: ProductDetailsInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentDetailDevice(device: DeviceObject){
        output.presentDetailDevice(device: device)
    }
}
