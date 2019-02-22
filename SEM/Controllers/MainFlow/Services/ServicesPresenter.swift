//
//  ServicesPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ServicesPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentListEmployees(list: [EmployeesObject])
}
class ServicesPresenter {
    var output: ServicesPresenterOutput!
}
extension ServicesPresenter: ServicesInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentListEmployees(list: [EmployeesObject]){
        output.presentListEmployees(list: list)
    }
}
