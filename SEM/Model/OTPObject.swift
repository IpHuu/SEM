//
//  OTPObject.swift
//  lela
//
//  Created by Ip Man on 11/8/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import ObjectMapper

class OTPObject: Mappable{
    var otpStatus: Int = 0
    var idClient = ""
    var otpCode = ""
    var otpUUID = ""
    var otpID: Int? = nil
    var phone = ""
    
    var expiresAt = ""
    var updatedAt = ""
    var createdAt = ""
    var completeAt = ""
    var confirmAt = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        otpStatus       <- (map["status"], IntegerTransform())
        otpCode         <- map["code"]
        otpUUID         <- map["uuid"]
        phone           <- map["phone"]
        idClient        <- map["idClient"]
        otpID           <- (map["id"], IntegerTransform())
        expiresAt       <- map["expiresAt"]
        updatedAt       <- map["updatedAt"]
        createdAt       <- map["createdAt"]
        completeAt      <- map["completeAt"]
        confirmAt       <- map["confirmAt"]
    }
}

