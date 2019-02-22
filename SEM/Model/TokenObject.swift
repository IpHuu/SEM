//
//  TokenObject.swift
//  SEM
//
//  Created by Ip Man on 12/28/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import ObjectMapper

class TokenObject: Mappable {
    var id: Int? = nil
    var idCustomer: Int? = nil
    var idClient = ""
    var token = ""
    var tokenExpires = ""
    var refreshToken = ""
    var refreshTokenExpires = ""
    var createdAt = ""
    var updatedAt = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id              <- (map["id"], IntegerTransform())
        idCustomer      <- (map["idCustomer"], IntegerTransform())
        idClient        <- map["idClient"]
        token           <- map["token"]
        tokenExpires    <- map["tokenExpires"]
        refreshToken    <- map["refreshToken"]
        refreshTokenExpires           <- map["refreshTokenExpires"]
        createdAt    <- map["createdAt"]
        updatedAt    <- map["updatedAt"]
    }
}
