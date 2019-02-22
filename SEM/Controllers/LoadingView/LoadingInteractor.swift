//
//  LoadingInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol LoadingInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentFetchCustomer(object: CustomerObject)
}
class LoadingInteractor {
    var output: LoadingInteractorOutput!
    func getMe(){
        self.output.needPresentLoading(true)
        APIServices.getMe(){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentFetchCustomer(object: data)
                return
            }
            if response.result.error.code == ErrorTokenType.ERR_TOKEN_EXP.rawValue{
                MyFunctions.refreshToken(){
                    result in
                    if result {
                        self.getMe()
                    }
                }
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
