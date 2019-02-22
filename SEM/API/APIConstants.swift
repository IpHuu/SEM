//
//  APIConstants.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
struct APIConstants {
    static let baseURLAuth = "http://apisem.bookoke.com/v1/auth/"
    static let baseURLNoneAuth = "http://apisem.bookoke.com/v1/"
    static let baseURLImage = "http://apisem.bookoke.com/uploads"
    static let clientId = "2"
    static let hashcode = "e23c79b3e195b0bff7801b7029ceae60"
    
    struct ActionAuth {
        static let registerSendCodeOTP = "registerSendCodeOTP"
        static let registerConfirmOTP = "registerConfirmOTP"
        static let registerCustomer = "registerCustomer"
        static let login = "login"
        static let loginSocial = "loginSocial"
        static let registerSocial = "registerSocial"
        static let registerForgotPassword = "registerForgotPassword"
        static let me = "me"
        static let refreshToken = "refreshToken"
        static let forgotChangePassword = "forgotChangePassword/"
        static let customer = "customer"
        static let profile = "profile"
        static let qrUUID = "qrUUID"
        static let changePassword = "changePassword"
        static let device = "device/"
        static let groupDevice =  "groupDevice/"
        static let detail = "detail/"
    }
    struct ActionInvoice {
        static let invoice = "invoice/"
        static let invoiceCodeDiscount = "invoice/codediscount"
        static let invoiceShipment =  "invoice/shipment"
        static let invoicePayment = "invoice/payment"
        static let invoiceHistory = "invoice/history/"
    }
    struct ActionEmployees {
        static let getListEmployees = "employee/management/location/"
    }
    struct Google{
        static var clientId: String?{
            guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else{
                return nil
            }
            
            guard let data = NSDictionary(contentsOfFile: path) else{
                return nil
            }
            
            return data["CLIENT_ID"] as? String
        }
        static var apiKey: String?{
            guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else{
                return nil
            }
            
            guard let data = NSDictionary(contentsOfFile: path) else{
                return nil
            }
            
            return data["API_KEY"] as? String
        }
        static let placeKey = "AIzaSyBiNl8DaUzx-jpFwV59xA4bsMN6EzqMqvU"
        static let GGMapAPIRootURL = "https://maps.googleapis.com/maps/api/"
        
        static let GGPlaceAutoCompleteURL = GGMapAPIRootURL+"place/autocomplete/json"
        static let GGDirections = GGMapAPIRootURL+"directions/json"
    }
    struct Facebook {
        static let appId = ""
    }
}
