//
//  TableOrderListPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol TableOrderListPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentListHistoryOrder(listOrder: ListOrderObject)
}
class TableOrderListPresenter {
    var output: TableOrderListPresenterOutput!
}
extension TableOrderListPresenter: TableOrderListInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentListHistoryOrder(listOrder: ListOrderObject){
        output.presentListHistoryOrder(listOrder: listOrder)
    }
}
