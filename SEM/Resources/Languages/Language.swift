//
//  Language.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
class Language: NSObject {
    static var bundle: Bundle? = nil
    func initialize(){
        let current = Language.getCurrentLanguage()
        Language.setLanguage(current)
    }
    class func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: "curren_language")
        UserDefaults.standard.synchronize()
        var filePath = "\(Language.appDocumentDirectory())/\(language).lproj"
        let exists = FileManager.default.fileExists(atPath: filePath)
        if !exists {
            filePath = Bundle.main.path(forResource: language, ofType: "lproj")!
        }
        Language.bundle = Bundle(path: filePath)
    }
    
    class func getCurrentLanguage() -> String {
        let defs = UserDefaults.standard
        let lang = defs.object(forKey: "curren_language") as! String?
        if lang?.count == 0 {
            return lang!
        }else {
            return "vi"
        }
    }
    class func get(_ key: String) -> String {
        var result = Language.bundle!.localizedString(forKey: key, value: nil, table: nil)
        if result == "" {
            result = key
        }
        return result
    }
    
    class func appDocumentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    class func getLanguageCode(_ language: String) -> String {
        switch language {
        case "English":
            return "en"
        default:
            return "vi"
        }
    }
}
