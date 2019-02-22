//
//  TableOrderListInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol TableOrderListInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentListHistoryOrder(listOrder: ListOrderObject)
}
class TableOrderListInteractor {
    var output: TableOrderListInteractorOutput!
    func fetchListHistoryOrder(status: Int){
        self.output.needPresentLoading(true)
        APIServices.getListHistoryOrder(statusOrder: status){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentListHistoryOrder(listOrder: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
