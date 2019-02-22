//
//  MQTTManager.swift
//  SEM
//
//  Created by Ipman on 2/18/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import Foundation
import CocoaMQTT
class MQTTManager {
    static var sharedInstance = MQTTManager()
    
    func initMQTT(username: String, password: String) -> CocoaMQTT{
        let clientID = String(ProcessInfo().processIdentifier)
        let mqtt = CocoaMQTT(clientID: clientID, host: MQTTConstants.host, port: MQTTConstants.port)
        
        mqtt.username = username
        mqtt.password = password
        mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt.keepAlive = 60
        mqtt.enableSSL = false
        
        return mqtt
    }
    
    private func getClientCertFromP12File(certName: String, certPassword: String) -> CFArray? {
        // get p12 file path
        let resourcePath = Bundle.main.path(forResource: certName, ofType: "p12")
        
        guard let filePath = resourcePath, let p12Data = NSData(contentsOfFile: filePath) else {
            print("Failed to open the certificate file: \(certName).p12")
            return nil
        }
        
        // create key dictionary for reading p12 file
        let key = kSecImportExportPassphrase as String
        let options : NSDictionary = [key: certPassword]
        
        var items : CFArray?
        let securityError = SecPKCS12Import(p12Data, options, &items)
        
        guard securityError == errSecSuccess else {
            if securityError == errSecAuthFailed {
                print("ERROR: SecPKCS12Import returned errSecAuthFailed. Incorrect password?")
            } else {
                print("Failed to open the certificate file: \(certName).p12")
            }
            return nil
        }
        
        guard let theArray = items, CFArrayGetCount(theArray) > 0 else {
            return nil
        }
        
        let dictionary = (theArray as NSArray).object(at: 0)
        guard let identity = (dictionary as AnyObject).value(forKey: kSecImportItemIdentity as String) else {
            return nil
        }
        let certArray = [identity] as CFArray
        
        return certArray
    }
}
