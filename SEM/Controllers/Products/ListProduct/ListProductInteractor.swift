//
//  ListProductInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

protocol ListProductInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentFetchListDeviceSuccess(listObject: [DeviceObject], paging: PagingObject)
}
class ListProductInteractor {
    var output: ListProductInteractorOutput!

    func fetchListDevice(groupID: Int, page: Int, lpp: Int){
        self.output.needPresentLoading(true)
        APIServices.getListDevice(groupID: groupID, page: page, lpp: lpp){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentFetchListDeviceSuccess(listObject: data, paging: response.result.paging)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
