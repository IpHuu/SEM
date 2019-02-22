//
//  PaymentObject.swift
//  SEM
//
//  Created by Ipman on 1/14/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class PaymentObject: Mappable {
    var id: Int? = nil
    var name = ""
    var description = ""
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name <- map["name"]
        description <- map["description"]
    }
}
