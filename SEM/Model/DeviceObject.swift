//
//  DeviceObject.swift
//  SEM
//
//  Created by Ipman on 1/7/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
//"id": "1",
//"name": "Cảm biến chuyển động PNC",
//"description": "Với độ chính xác cao",
//"price": "$1.00",
//"parameter": 1,
//"evaluate": null,
//"img": "1"
class DeviceObject: Mappable{
    var id: Int? = nil
    var name = ""
    var description = ""
    var price: Double = 0
    var basePrice: Double = 0
    var salePrice: Double = 0
    var prameter = ""
    var evaluate = ""
    var img = ""
    var quantity: Int = 1
    required convenience init?(map: Map) {
        self.init()
    }
    
    func increaseQuantity(){
        self.quantity += 1
    }
    func reductionQuantity(){
        if self.quantity > 0{
            self.quantity -= 1
        }
    }
    
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name <- map["name"]
        description <- map["description"]
        price <- (map["price"], DoubleTransform())
        basePrice <- (map["basePrice"], DoubleTransform())
        salePrice <- (map["salePrice"], DoubleTransform())
        prameter <- map["prameter"]
        evaluate <- map["evaluate"]
        img <- map["img"]
        quantity <- (map["quantity"], IntegerTransform())
    }
}
