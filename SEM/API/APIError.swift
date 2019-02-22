//
//  APIError.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper

class APIError: Error {
    var message: String
    var code: String
    var errorCode: Int
    
    // Init default error
    convenience init(){
        self.init(message: "Unknown error occurred",
                  code: "Unknown code",
                  errorCode: -1)
    }
    
    init(message: String, code: String = "", errorCode: Int = -1) {
        self.message = message
        self.code = code
        self.errorCode = -1
    }
}
