//
//  CartsInteractor.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import Alamofire
protocol CartsInteractorOutput {
    func needPresentLoading(_ isLoading: Bool)
    func needPresentAlert(message: String)
    func needPresentError(error: APIError)
    func needPresentListShipment(list: [ShipmentObject])
    func needPresentSearch(placesPrediction: [GGPredictionObject])
    func needPresentCheckCodePromotion(object: PromotionObject)
}
class CartsInteractor {
    var output: CartsInteractorOutput!
    var currentRequest: Request?
    
    func cancelRequest(){
        if let request = self.currentRequest{
            request.cancel()
            self.currentRequest = nil
        }
    }
    func checkCodeDiscount(code: String){
        self.output.needPresentLoading(true)
        APIServices.checkCodeDiscount(code: code){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data{
                self.output.needPresentCheckCodePromotion(object: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func getListShipment(){
        self.output.needPresentLoading(true)
        APIServices.listShipment(){
            response in
            self.output.needPresentLoading(false)
            if let data = response.result.data {
                self.output.needPresentListShipment(list: data)
                return
            }
            self.output.needPresentError(error: response.result.error)
        }
    }
    
    func searchPlaces(address: String, andLat lat: Double, andLng lng: Double){
        APIServices.searchPlaces(byQuery: address, withLat: lat, withLng: lng){
            place, error in
            if let place = place{
                self.output.needPresentSearch(placesPrediction: place)
                return
            }
            
            if let _ = error{
                print("error getting google autocomplete address")
            }
            
        }
    }
}
