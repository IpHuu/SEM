//
//  ServicesInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
protocol ServicesInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentListEmployees(list: [EmployeesObject])
}
class ServicesInteractor {
    var output: ServicesInteractorOutput!
    
    func getListEmployees(lat: Double, long: Double, distance: Int){
        self.output.needPresentLoading(true)
        APIServices.getListEmployees(lat: lat, long: long, distance: distance){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentListEmployees(list: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
}
