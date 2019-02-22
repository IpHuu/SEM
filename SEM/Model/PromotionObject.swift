//
//  PromotionObject.swift
//  SEM
//
//  Created by Ipman on 1/16/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class PromotionObject: Mappable {
    var id: Int? = nil
    var name = ""
    var code = ""
    var type: Int? = nil
    var quantity: Double = 0
    var role: Int? = nil
    var experiedAt = ""
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name    <- map["name"]
        code    <- map["code"]
        type    <- (map["type"], IntegerTransform())
        quantity    <- (map["quantity"], DoubleTransform())
        role        <- (map["role"], IntegerTransform())
        experiedAt  <- map["experiedAt"]
    }
}
