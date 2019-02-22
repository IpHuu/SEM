//
//  APIResponse.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import ObjectMapper
//import SWXMLHash
//import StringExtensionHTML
//import AEXML

class BaseResponse{
    
    func getDataString(from xmlString: [String: Any]?=nil, action: String) -> String?{
        var theJSONText: String = ""
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: xmlString as Dictionary!,
            options: []) {
            theJSONText = String(data: theJSONData,
                                 encoding: .utf8)!
        }
        print("/*****")
        print("Action "+action)
        print("Service response "+theJSONText)
        print("*****/")
        
        return theJSONText
        
    }
}

class GenericResponse<Value>: BaseResponse{
    
    var result = GenericDataResponse<Value>()
    
    public init(xmlString: [String: Any]?=nil, action: String="", error: Error?=nil){
        super.init()
        if let error = error{
            self.result.errorMessage = error.localizedDescription
            return
        }
        
        if let dataString = getDataString(from: xmlString, action: action){
            // convert string to dictionary
            if let resultObject = Mapper<GenericDataResponse<Value>>().map(JSONString: dataString){
                self.result = resultObject
                return
            }
            
            // get error directly from SOAP system
            self.result.errorMessage = dataString
            return
        }
    }
}

class GenericObjectResponse<Value: Mappable>: BaseResponse{
    var result = GenericObjectDataResponse<Value>()
    
    public init(xmlString: [String: Any]?=nil, action: String="", error: Error?=nil){
        super.init()
        if let error = error{
            self.result.errorMessage = error.localizedDescription
            return
        }
        
        if let dataString = getDataString(from: xmlString, action: action){
            // convert string to dictionary
            if let resultObject = Mapper<GenericObjectDataResponse<Value>>().map(JSONString: dataString){
                self.result = resultObject
                return
            }
            
            // get error directly from SOAP system
            self.result.errorMessage = dataString
            return
        }
    }
}

class GenericArrayResponse<Value: Mappable>: BaseResponse{
    var result = GenericArrayDataResponse<Value>()
    
    public init(xmlString: [String: Any]?=nil, action: String="", error: Error?=nil){
        super.init()
        if let error = error{
            self.result.errorMessage = error.localizedDescription
            return
        }
        
        if let dataString = getDataString(from: xmlString, action: action){
            // convert string to dictionary
            if let resultObject = Mapper<GenericArrayDataResponse<Value>>().map(JSONString: dataString){
                self.result = resultObject
                return
            }
            
            // get error directly from SOAP system
            self.result.errorMessage = dataString
            return
        }
    }
}

class BaseDataResponse: Mappable{
    
    private var rawStatus: Bool = false
    var isSuccess: Bool{
        if rawStatus{
            return true
        }
        return false
    }
    
    var error: APIError{
        return APIError(message: errorMessage, code: errorCode)
    }
    
    fileprivate var errorCode: String = "Code Unknown"
    fileprivate var errorMessage: String = "Unknown"
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        rawStatus       <- map["success"]
        errorCode       <- map["errorCode"]
        errorMessage    <- map["message"]
    }
}

//class GenericObjectTokenResponse<Value: Mappable>: BaseDataResponse  {
//    var token: Value?
//    var refreshToken: Value?
//    required convenience init?(map: Map) {
//        self.init()
//
//    }
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        token            <- map["token"]
//        refreshToken     <- map["refreshToken"]
//    }
//}

class GenericDataResponse<Value>: BaseDataResponse{
    
    var data: Value?
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data            <- map["data"]
    }
}

class GenericObjectDataResponse<Value: Mappable>: BaseDataResponse{
    
    var data: Value?
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data            <- map["data"]
    }
}

class GenericArrayDataResponse<Value : Mappable>: BaseDataResponse{
    var data: [Value]?
    var paging = PagingObject()
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        paging          <- map["paging"]
        data            <- map["data"]
    }
}
