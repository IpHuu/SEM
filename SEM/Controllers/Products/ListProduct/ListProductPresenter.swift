//
//  ListProductPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ListProductPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentFetchListDeviceSuccess(listObject: [DeviceObject], paging: PagingObject)
}
class ListProductPresenter {
    var output: ListProductPresenterOutput!
}
extension ListProductPresenter: ListProductInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentFetchListDeviceSuccess(listObject: [DeviceObject], paging: PagingObject){
        output.presentFetchListDeviceSuccess(listObject: listObject, paging: paging)
    }
}
