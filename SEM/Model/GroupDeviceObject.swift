//
//  GroupDeviceObject.swift
//  SEM
//
//  Created by Ipman on 1/7/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupDeviceObject: Mappable{
    var id: Int? = nil
    var name: String = ""
    var description =  ""
    var img =  ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], IntegerTransform())
        name <- map["name"]
        description <- map["description"]
        img <- map["img"]
    }
}
