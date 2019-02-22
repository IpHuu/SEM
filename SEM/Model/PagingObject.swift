//
//  PagingObject.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import ObjectMapper
class PagingObject: Mappable {
    var number_record: Int = 0
    var num_pages: Int = 0
    var cur_page: Int = 0
    var lpp: Int = 0
    var start_num: Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        
        number_record         <- (map["number_record"], IntegerTransform())
        num_pages        <- (map["pages"], IntegerTransform())
        cur_page        <- (map["cur_page"], IntegerTransform())
        lpp             <- (map["lpp"], IntegerTransform())
        start_num       <- (map["start_num"], IntegerTransform())
    }
}
