//
//  GGPlaceObject.swift
//  SEM
//
//  Created by Ipman on 1/15/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
class GGPlaceObject: Mappable {
    var lat: Double = 0
    var long: Double = 0
    var icon: String = ""
    var id: String = ""
    var name: String = ""
    var address: String = ""
    var types = [String]()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat      <- map["geometry.location.lat"]
        long     <- map["geometry.location.lng"]
        icon     <- map["icon"]
        id       <- map["place_id"]
        name     <- map["name"]
        address  <- map["formatted_address"]
        types    <- map["types"]
    }
}
class GGPredictionObject: Mappable {
    var id = ""
    var description = ""
    var placeId = ""
    var mainText = ""
    var secondaryText = ""
    var matchedSubstrings = [GGMatchedSubstringsObject]()
    var types = [String]()
    var terms = [GGTermsObject]()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        description  <- map["description"]
        placeId     <- map["place_id"]
        mainText    <- map["structured_formatting.main_text"]
        secondaryText   <- map["structured_formatting.secondary_text"]
        types    <- map["types"]
        matchedSubstrings <- map["matched_substrings"]
        terms    <- map["terms"]
    }
}

class GGTermsObject: Mappable {
    
    var offset: Int = 0
    var value = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        offset <- (map["offset"], IntegerTransform())
        value <- map["value"]
    }
}

class GGMatchedSubstringsObject: Mappable {
    var offset: Int = 0
    var length: Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        offset <- (map["offset"], IntegerTransform())
        length <- (map["length"], IntegerTransform())
    }
}
class GGDirectionsObject: Mappable {
    var overview_polyline = Dictionary<String, Any>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        overview_polyline   <- map["overview_polyline"]
    }
}
