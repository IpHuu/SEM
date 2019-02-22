//
//  ProductsPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ProductsPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentListGroupDevice(data: [GroupDeviceObject])
}
class ProductsPresenter {
    var output: ProductsPresenterOutput!
}
extension ProductsPresenter: ProductsInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentListGroupDevice(data: [GroupDeviceObject]){
        output.presentListGroupDevice(data: data)
    }
}
