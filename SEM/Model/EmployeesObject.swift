//
//  EmployeesObject.swift
//  SEM
//
//  Created by Ipman on 1/30/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class EmployeesObject: Mappable {
    var id:Int? = nil
    var name = ""
    var lat: Double = 0
    var lng: Double = 0
    var phone = ""
    var email = ""
    var uuid = ""
    var gender: Int = 0
    
    required convenience init?(map: Map){
        self.init()
    }
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name    <- map["name"]
        lat    <- (map["lat"], DoubleTransform())
        lng    <- (map["long"], DoubleTransform())
        phone    <- map["phone"]
        email    <- map["email"]
        uuid    <- map["uuid"]
        gender <- (map["gender"], IntegerTransform())
    }
}
