//
//  CartsPresenter
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//
import UIKit
protocol CartsPresenterOutput {
    func presentLoading(_ isLoading: Bool)
    func presentAlert(message: String)
    func presentError(error: APIError)
    func presentListShipment(list: [ShipmentObject])
    func presentSearch(placesPrediction: [GGPredictionObject])
    func presentCheckCodePromotion(object: PromotionObject)
}
class CartsPresenter {
    var output: CartsPresenterOutput!
}
extension CartsPresenter: CartsInteractorOutput{
    func needPresentLoading(_ isLoading: Bool){
        output.presentLoading(isLoading)
    }
    func needPresentAlert(message: String){
        output.presentAlert(message: message)
    }
    func needPresentError(error: APIError){
        output.presentError(error: error)
    }
    func needPresentListShipment(list: [ShipmentObject]){
        output.presentListShipment(list: list)
    }
    func needPresentSearch(placesPrediction: [GGPredictionObject]){
        output.presentSearch(placesPrediction: placesPrediction)
    }
    func needPresentCheckCodePromotion(object: PromotionObject){
        output.presentCheckCodePromotion(object: object)
    }
}
