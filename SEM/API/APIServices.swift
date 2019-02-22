//
//  APIServices.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

typealias SocialInfo = (provider: String, id: String, name: String, email: String, avatar: String, token: String)
typealias StringResultHandler = (GenericResponse<String>) -> ()
typealias OTPObjectResultHandler = (GenericObjectResponse<OTPObject>) -> ()
typealias CustomerObjectResultHandler = (GenericObjectResponse<CustomerObject>) -> ()
typealias TokenResultHandler = (GenericObjectResponse<TokenObject>) -> ()
typealias GetListDeviceResultHandler = (GenericArrayResponse<DeviceObject>) -> ()
typealias GetListGroupDeviceResultHandler = (GenericArrayResponse<GroupDeviceObject>) -> ()
typealias DeviceObjectResultHandler = (GenericObjectResponse<DeviceObject>) -> ()
typealias ListShipmentResultHandler = (GenericArrayResponse<ShipmentObject>) -> ()
typealias ListPaymentResultHandler = (GenericArrayResponse<PaymentObject>) -> ()
typealias PlaceAutocompleteResultHandler = ([GGPredictionObject]?, APIError?) -> ()
typealias PromotionResultHandler = (GenericObjectResponse<PromotionObject>) -> ()
typealias OrderObjectResultHandler = (GenericObjectResponse<OrderObject>) -> ()
typealias ListOrderObjectResultHandler = (GenericObjectResponse<ListOrderObject>) -> ()
typealias OrderDetailObjectResultHandler = (GenericObjectResponse<OrderDetailObject>) -> ()
typealias GGDirectionsResultHandler = ([GGDirectionsObject]?, APIError?)->()
typealias ArrayEmployeesResultHandler = (GenericArrayResponse<EmployeesObject>) -> ()


class APIServices: NSObject{
    
    static let sharedInstance = APIServices()
    static func urlRequest(baseURL: String, ActionAuth: String, parameters: [String: Any]?=nil, method: String) -> URLRequest{
        let url = URL(string:baseURL+ActionAuth)!
        var request = URLRequest(url:url)
        request.httpMethod = method
        let headerRequest: HTTPHeaders = [
            "Content-Type": "application/json",
            "clientid"  : APIConstants.clientId,
            "versionos"  : UIDevice.current.systemVersion,
            "versionapp" : (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
            "devicename" : UIDevice.current.name,
            "hashcode" : APIConstants.hashcode,
            "x-access-token" : (ActionAuth == APIConstants.ActionAuth.refreshToken) ? AuthenticationManager.sharedInstance.catchToken.refreshToken : AuthenticationManager.sharedInstance.catchToken.token
        ]
        request.allHTTPHeaderFields = headerRequest
        if let params = parameters{
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        return request
    }
    static func refreshToken(token: String ,completion: @escaping TokenResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.refreshToken, parameters: nil, method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<TokenObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.refreshToken))
            case .failure(let error):
                completion(GenericObjectResponse<TokenObject>(error: error))
            }
        }
    }
    // MARK: LOGIN
    static func Login(username: String , password: String, completion: @escaping TokenResultHandler){
        let params = ["username": username,
                      "password": password] as [String : Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.login, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<TokenObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.login))
            case .failure(let err):
                completion(GenericObjectResponse<TokenObject>(error: err))
            }
        }
    }
    // MARK: REGISTER ACCOUNT
    static func registerSendCodeOTP(phone: String, completion: @escaping OTPObjectResultHandler){
        let params = ["phone": phone] as [String: Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.registerSendCodeOTP, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<OTPObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.registerSendCodeOTP))
            case .failure(let err):
                completion(GenericObjectResponse<OTPObject>(error: err))
            }
        }
    }
    static func registerConfirmOTP(otpID: Int, otpCode: String, completion: @escaping OTPObjectResultHandler){
        let params = ["id": String(otpID),
                      "code": otpCode] as [String: Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.registerConfirmOTP, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<OTPObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.registerConfirmOTP))
            case .failure(let err):
                completion(GenericObjectResponse<OTPObject>(error: err))
            }
        }
    }
    static func registerCustomer(customer: CustomerObject, completion: @escaping CustomerObjectResultHandler){
        let params = CustomerObject.toJSON(customer)
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.registerCustomer, parameters: params(), method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<CustomerObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.registerCustomer))
            case .failure(let err):
                completion(GenericObjectResponse<CustomerObject>(error: err))
            }
        }
    }
    
    static func registerForgotPassword(phone: String, completion: @escaping OTPObjectResultHandler){
        let params = ["phone": phone] as [String: Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.registerForgotPassword, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<OTPObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.registerSendCodeOTP))
            case .failure(let err):
                completion(GenericObjectResponse<OTPObject>(error: err))
            }
        }
    }
    
    static func forgotChangePassword(otpUUID: String, password: String, confirmPassword: String, completion: @escaping StringResultHandler){
        let params = ["password": password,
                      "passwordConfirm": confirmPassword] as [String: Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.forgotChangePassword + "\(otpUUID)", parameters: params, method: "PUT")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericResponse<String>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.forgotChangePassword + "\(otpUUID)"))
            case .failure(let err):
                completion(GenericResponse<String>(error: err))
            }
        }
        
    }
    
    static func loginSocial(social: SocialInfo, completion: @escaping TokenResultHandler){
        let params = ["provider": social.provider,
                      "providerID": social.id,
                      "providerName": social.name,
                      "providerEmail": social.email,
                      "providerPic": social.avatar,
                      "providerToken": social.token] as [String : Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.loginSocial, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<TokenObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.loginSocial))
            case .failure(let err):
                completion(GenericObjectResponse<TokenObject>(error: err))
            }
        }
    }
    
    static func registerSocial(social: SocialInfo, otp: OTPObject, completion: @escaping TokenResultHandler){
        let params = ["provider": social.provider,
                      "providerID": social.id,
                      "providerName": social.name,
                      "providerEmail": social.email,
                      "providerPic": social.avatar,
                      "providerIdOtp": String(otp.otpID!),
                      "providerToken": social.token] as [String : Any]
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.registerSocial, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{ response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<TokenObject>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.registerSocial))
            case .failure(let err):
                completion(GenericObjectResponse<TokenObject>(error: err))
            }
        }
    }
    
    static func updatePassword(passCurr: String, passNew: String, passConfirm: String, completion: @escaping StringResultHandler){
        let params = ["passwordCurrent": passCurr,
                      "password": passNew,
        "passwordConfirm": passConfirm] as [String: Any]
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionAuth.customer + APIConstants.ActionAuth.changePassword, parameters: params, method: "PUT")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericResponse<String>(xmlString: value as? [String : Any], action: APIConstants.ActionAuth.customer + APIConstants.ActionAuth.changePassword))
            case .failure(let err):
                completion(GenericResponse<String>(error: err))
            }
            
        }
    }
    
    // MARK: Profile
    static func getMe(completion:@escaping CustomerObjectResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLAuth, ActionAuth: APIConstants.ActionAuth.me, parameters: nil, method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<CustomerObject>(xmlString: value as? [String : Any],
                                                                 action: APIConstants.ActionAuth.me))
            case .failure(let error):
                completion(GenericObjectResponse<CustomerObject>(error: error))
            }
        }
    }
    
    static func updateProfile(image: UIImage, name: String, email: String, address: String, gender: Int, completion: @escaping CustomerObjectResultHandler){
        let params = ["name":name,
                      "email":email,
                      "address":address,
                      "gender":gender] as [String : Any]
        let headerRequest: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "clientid"  : APIConstants.clientId,
            "versionos"  : UIDevice.current.systemVersion,
            "versionapp" : (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
            "devicename" : UIDevice.current.name,
            "hashcode" : APIConstants.hashcode,
            "x-access-token" : AuthenticationManager.sharedInstance.catchToken.token
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = UIImageJPEGRepresentation(image.resizeImage(targetSize: CGSize(width: 512, height: 512)), 1) {
                multipartFormData.append(imageData, withName: "file_upload", fileName: "myAvatar.jpeg", mimeType: "image/jpeg")
            }
            for key in params.keys{
                let name = String(key)
                if let val = params[name] as? String{
                    multipartFormData.append(val.data(using: .utf8)!, withName: name)
                }else if let val = params[name] as? Int {
                    multipartFormData.append("\(val)".data(using: .utf8)!, withName: name)
                }
            }}, to: APIConstants.baseURLNoneAuth + APIConstants.ActionAuth.customer, method: .put, headers: headerRequest,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload,_ , _):
                        upload.responseJSON { value in
                            completion(GenericObjectResponse<CustomerObject>(xmlString: value.result.value as? [String : Any],
                                                               action: APIConstants.baseURLNoneAuth + APIConstants.ActionAuth.customer))
                        }
                    case .failure(let encodingError):
                        completion(GenericObjectResponse<CustomerObject>(error: encodingError))
                    }
        })
    }
    
    // MARK: Device
    static func getListGroupDevice(completion: @escaping GetListGroupDeviceResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionAuth.device + APIConstants.ActionAuth.groupDevice , method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericArrayResponse<GroupDeviceObject>(xmlString: value as? [String : Any],
                                                              action: APIConstants.ActionAuth.device + APIConstants.ActionAuth.groupDevice))
            case .failure(let error):
                completion(GenericArrayResponse<GroupDeviceObject>(error: error))
            }
        }
    }
    static func getListDevice(groupID: Int, page: Int, lpp: Int, completion: @escaping GetListDeviceResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionAuth.device + "\(groupID)?page=\(page)&limit=\(lpp)" , method: "GET")
        
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericArrayResponse<DeviceObject>(xmlString: value as? [String : Any],
                                                                 action: APIConstants.ActionAuth.device + "\(groupID)?page=\(page)&limit=\(lpp)"))
            case .failure(let error):
                completion(GenericArrayResponse<DeviceObject>(error: error))
            }
        }
    }
    
    static func getDetailDevice(deviceId: Int, completion: @escaping DeviceObjectResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionAuth.device + APIConstants.ActionAuth.detail + "\(deviceId)", method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<DeviceObject>(xmlString: value as? [String : Any],
                                                                 action: APIConstants.ActionAuth.device + APIConstants.ActionAuth.detail + "\(deviceId)"))
            case .failure(let error):
                completion(GenericObjectResponse<DeviceObject>(error: error))
            }
        }
    }
    
    // MARK: ORDER
    static func checkCodeDiscount(code: String, completion: @escaping PromotionResultHandler){
        let params = ["code": code]
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoiceCodeDiscount, parameters: params, method: "POST")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<PromotionObject>(xmlString: value as? [String : Any],
                                                                action: APIConstants.ActionInvoice.invoiceCodeDiscount))
            case .failure(let error):
                completion(GenericObjectResponse<PromotionObject>(error: error))
            }
        }
    }
    
    static func listShipment(completion: @escaping ListShipmentResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoiceShipment, method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericArrayResponse<ShipmentObject>(xmlString: value as? [String : Any],
                                                               action: APIConstants.ActionInvoice.invoiceShipment))
            case .failure(let error):
                completion(GenericArrayResponse<ShipmentObject>(error: error))
            }
        }
    }
    
    static func listPayment(completion: @escaping ListPaymentResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoicePayment, method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericArrayResponse<PaymentObject>(xmlString: value as? [String : Any],
                                                                action: APIConstants.ActionInvoice.invoicePayment))
            case .failure(let error):
                completion(GenericArrayResponse<PaymentObject>(error: error))
            }
        }
    }
    
    static func createOrder(order: OrderObject, completion: @escaping OrderObjectResultHandler){
        //let JSONString = Mapper().toJSON(order)
        let params = OrderObject.toJSON(order)
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoice, parameters: params(), method: "POST")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<OrderObject>(xmlString: value as? [String : Any],
                                                                  action: APIConstants.baseURLNoneAuth + APIConstants.ActionInvoice.invoice))
            case .failure(let error):
                completion(GenericObjectResponse<OrderObject>(error: error))
            }
        }
    }
    
    static func getListHistoryOrder(statusOrder: Int, completion: @escaping ListOrderObjectResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoiceHistory + "\(statusOrder)", method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<ListOrderObject>(xmlString: value as? [String : Any],
                                                              action: APIConstants.baseURLNoneAuth + APIConstants.ActionInvoice.invoiceHistory + "\(statusOrder)"))
            case .failure(let error):
                completion(GenericObjectResponse<ListOrderObject>(error: error))
            }
        }
    }
    
    static func getOrderDetail(idOrder: Int, completion: @escaping OrderDetailObjectResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionInvoice.invoice + "\(idOrder)", method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericObjectResponse<OrderDetailObject>(xmlString: value as? [String : Any],
                                                                  action: APIConstants.baseURLNoneAuth + APIConstants.ActionInvoice.invoice + "\(idOrder)"))
            case .failure(let error):
                completion(GenericObjectResponse<OrderDetailObject>(error: error))
            }
        }
        
    }
    
    // MARK: Google API
    
    static func searchPlaces(byQuery query: String, withLat lat: Double, withLng lng: Double, completion: @escaping PlaceAutocompleteResultHandler){
        let params = ["input"       : query,
                      "types"       : "geocode",
                      "language"    : "vi",
                      "radius"      : 5000,
                      "key"         : APIConstants.Google.placeKey] as [String : Any]
        
        Alamofire.request(APIConstants.Google.GGPlaceAutoCompleteURL, method: .get, parameters: params).responseJSON {
            response in
            switch response.result{
            case .success(let value):
                if let dict = value as? NSDictionary{
                    let data = dict.value(forKey: "predictions")
                    if let places = Mapper<GGPredictionObject>().mapArray(JSONObject: data){
                        completion(places, nil)
                        return
                    }
                }
                completion(nil, APIError(message: "No data"))
                
            case .failure(let error):
                completion(nil, APIError(message: error.localizedDescription))
            }
        }
        
    }
    /// getDirections - google map direction Ve duong di giua 2 diem tren ban do
    ///
    /// - Action Url: maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=
    /// - Parameters:
    ///   - origins: diem bat dau
    ///   - destinations: diem ket thuc
    ///   - resultHandler: GGDirectionsObject
    static func getDirections(origins: String, destinations: String,
                              resultHandler: @escaping GGDirectionsResultHandler){
        let params = ["origin"      : "\(origins)",
            "destination" : "\(destinations)",
            "key"         : APIConstants.Google.placeKey]
        
        Alamofire.request(APIConstants.Google.GGDirections, method: .get, parameters: params)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    if let dict = value as? NSDictionary{
                        if let data = dict.value(forKey: "routes") {
                            if let direction = Mapper<GGDirectionsObject>().mapArray(JSONObject: data) {
                                resultHandler(direction, nil)
                                return
                            }
                        }
                    }
                    resultHandler(nil, APIError(message: "Direction not found"))
                    
                case .failure(let error):
                    print(error)
                    resultHandler(nil, APIError(message: error.localizedDescription))
                }
        }
    }
    
    // MARK: Employees
    static func getListEmployees(lat: Double, long: Double, distance: Int, completion: @escaping ArrayEmployeesResultHandler){
        let request = urlRequest(baseURL: APIConstants.baseURLNoneAuth, ActionAuth: APIConstants.ActionEmployees.getListEmployees + "\(long)/\(lat)/\(distance)", method: "GET")
        Alamofire.request(request).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                completion(GenericArrayResponse<EmployeesObject>(xmlString: value as? [String : Any],
                                                                    action: APIConstants.baseURLNoneAuth + APIConstants.ActionEmployees.getListEmployees + "\(long)/\(lat)/\(distance)"))
            case .failure(let error):
                completion(GenericArrayResponse<EmployeesObject>(error: error))
            }
        }
    }
    
}
