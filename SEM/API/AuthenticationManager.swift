//
//  AuthenticationManager.swift
//  SEM
//
//  Created by Ipman on 12/28/18.
//  Copyright © 2018 Ipman. All rights reserved.
//
import UIKit
import ObjectMapper
private enum AuthenticatedKey: String {
    case login = "IsLogged"
    case tokenInfo = "tokenInfo"
    case userInfo = "userInfo"
    case cartProduct = "cartProduct"
}
class AuthenticationManager: NSObject {
    static let sharedInstance = AuthenticationManager()
    override init() {
    }
    let userDefault = UserDefaults.standard
    var catchToken: TokenObject{
        get{
            if let jsonString = userDefault.string(forKey: AuthenticatedKey.tokenInfo.rawValue){
                if let customer = Mapper<TokenObject>().map(JSONString: jsonString){
                    return customer
                }
            }
            
            return TokenObject()
        }
        set{
            if let jsonString = newValue.toJSONString(){
                userDefault.set(jsonString, forKey: AuthenticatedKey.tokenInfo.rawValue)
                return
            }
            
            userDefault.set("", forKey: AuthenticatedKey.tokenInfo.rawValue)
        }
    }
    func removeCachedToken(){
        userDefault.set("", forKey: AuthenticatedKey.tokenInfo.rawValue)
    }
    
    var isLoggedIn: Bool{
        get{
            let isLoggedIn = userDefault.bool(forKey: AuthenticatedKey.login.rawValue)
            return isLoggedIn
        }
        set{
            userDefault.set(newValue, forKey: AuthenticatedKey.login.rawValue)
        }
    }
    
    var cachedCustomer: CustomerObject{
        get{
            if let jsonString = userDefault.string(forKey: AuthenticatedKey.userInfo.rawValue){
                if let customer = Mapper<CustomerObject>().map(JSONString: jsonString){
                    return customer
                }
            }
            
            return CustomerObject()
        }
        set{
            if let jsonString = newValue.toJSONString(){
                userDefault.set(jsonString, forKey: AuthenticatedKey.userInfo.rawValue)
                return
            }
            
            userDefault.set("", forKey: AuthenticatedKey.userInfo.rawValue)
        }
    }
    
    func removeCachedCustomer(){
        userDefault.set("", forKey: AuthenticatedKey.userInfo.rawValue)
    }
    
    var cachedCartDevice: [DeviceObject]{
        get{
            
            if let jsonString = userDefault.string(forKey: AuthenticatedKey.cartProduct.rawValue){
                if let cart = Mapper<DeviceObject>().mapArray(JSONString: jsonString){
                    return cart
                }
            }
            
            return [DeviceObject]()
        }
        set{
            if let jsonString = newValue.toJSONString(){
                userDefault.set(jsonString, forKey: AuthenticatedKey.cartProduct.rawValue)
                return
            }
            
            userDefault.set("", forKey: AuthenticatedKey.cartProduct.rawValue)
        }
    }
    func removeCartDevice(){
        userDefault.set("", forKey: AuthenticatedKey.cartProduct.rawValue)
    }
}
