//
//  ShipmentObject.swift
//  SEM
//
//  Created by Ipman on 1/14/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class ShipmentObject: Mappable {
    
    var id: Int? = nil
    var name = ""
    var unit = ""
    var price: Double = 0
    var distinct: Double = 0
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name <- map["name"]
        unit <- map["unit"]
        price <- (map["price"], DoubleTransform())
        distinct <- (map["distinct"], DoubleTransform())
    }
}
