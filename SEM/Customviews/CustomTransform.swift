//
//  CustomTransform.swift
//  lela
//
//  Created by Ip Man on 11/8/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import ObjectMapper

class CustomDateTransform: TransformType{
    
    typealias Object = Date
    typealias JSON = AnyObject
    
    func transformFromJSON(_ value: Any?) -> Date?{
        if let stringValue = value as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let object = formatter.date(from: stringValue)
            return object
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) ->  AnyObject?{
        return value as AnyObject?
    }
}

class CustomGasDateTransform: TransformType{
    
    typealias Object = Date
    typealias JSON = AnyObject
    
    func transformFromJSON(_ value: Any?) -> Date?{
        if let stringValue = value as? String{
            let formatter = DateFormatter()
            //2017-05-10 14:43:31
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let object = formatter.date(from: stringValue)
            return object
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) ->  AnyObject?{
        return value as AnyObject?
    }
}

class DoubleTransform: TransformType{
    typealias Object = Double
    typealias JSON = AnyObject
    
    func transformFromJSON(_ value: Any?) -> Double?{
        if let value = value as? String{
            if let doubleValue = Double(value){
                return doubleValue
            }
        }
        
        if let value = value as? Double{
            return value
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Double?) ->  AnyObject?{
        return value as AnyObject?
    }
}

class IntegerTransform: TransformType{
    typealias Object = Int
    typealias JSON = AnyObject
    
    func transformFromJSON(_ value: Any?) -> Int?{
        if let value = value as? String{
            if let intValue = Int(value){
                return intValue
            }
        }
        
        if let intValue = value as? Int{
            return intValue
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Int?) ->  AnyObject?{
        return value as AnyObject?
    }
}


