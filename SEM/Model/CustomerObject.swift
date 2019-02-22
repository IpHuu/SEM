//
//  CustomerObject.swift
//  SEM
//
//  Created by Ip Man on 11/8/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import ObjectMapper

//"customerUsername": "0393339812",
//"customerStatus": 0,
//"otpID": 22,
//"customerLinkMemberCard": null,
//"customerID": 8,
//"customerPoint": null,
//"customerAvatarPath": null,
//"customerPassword": "$2a$10$1NkBTO4YHoqgv4a8hDA3a.9s6IweW7J6SbkjpWVPGQ.uKPNF6SW42",
//"customerEmail": null,
//"customerAge": null,
//"createdAt": "2018-11-09T03:05:24.000Z",
//"customerNotiStatus": null,
//"updatedAt": "2018-11-09T03:05:24.000Z",
//"customerFbID": null,
//"customerFullname": "ipman",
//"customerModifyLoginAt": null,
//"customerPhone": "0393339812",
//"customerFirstLoginAt": null,
//"customerGgID": null,
//"customerBirthDay": null
class CustomerObject: Mappable  {
    var otpID: Int? = nil
    var id: Int? = nil
    var avatar =  ""
    var password = ""
    var email = ""
    var name = ""
    var address = ""
    var gender: Int = 0
    var isBlock: Int = 0
    var createAt = ""
    var updateAt = ""
    var fbId = ""
    var phone: String? = nil
    var ggId = ""
    var UUID = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func getNameGender() -> String{
        if self.gender == 0{
           return "Nữ"
        }else if self.gender == 1{
            return "Nam"
        }else{
            return "Khác"
        }
    }
    
    func mapping(map: Map) {
        otpID                   <- (map["idOtp"], IntegerTransform())
        id                      <- (map["id"], IntegerTransform())
        avatar                  <- map["img"]
        password                <- map["password"]
        email                   <- map["email"]
        address                 <- map["address"]
        name                    <- map["name"]
        gender                  <- (map["gender"], IntegerTransform())
        isBlock                 <- (map["isBlock"], IntegerTransform())
        createAt                <- map["createdAt"]
        updateAt                <- map["customerNotiStatus"]
        fbId                    <- map["fbId"]
        phone                   <- map["phone"]
        ggId                    <- map["ggId"]
        UUID                    <- map["uuid"]
    }
}
