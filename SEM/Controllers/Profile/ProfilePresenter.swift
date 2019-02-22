//
//  ProfilePresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol ProfilePresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentUpdateProfileSuccess(object: CustomerObject)
}
class ProfilePresenter {
    var output: ProfilePresenterOutput!
}
extension ProfilePresenter: ProfileInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentUpdateProfileSuccess(object: CustomerObject){
        output.presentUpdateProfileSuccess(object: object)
    }
}
