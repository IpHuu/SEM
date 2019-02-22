//
//  Validator.swift
//  SEM
//
//  Created by Ip Man on 10/30/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

struct Validator {
    typealias ValidateResult = (isValid: Bool, message: String)
    
    // validate phone
    static func validate(phoneNumber: String) -> ValidateResult{
        let phone = phoneNumber
        
        if phone.length == 0{
            return (false, Language.get("MISSING_PHONE_NUMBER_MESSAGE") )
        }
        
        if phone.length < 10 || phone.length > 11{
            return (false, Language.get("INVALID_PHONE_NUMBER_MESSAGE") )
        }
        
        let notDigitsSet = NSCharacterSet.decimalDigits.inverted
        if (phone as NSString).rangeOfCharacter(from: notDigitsSet).location != NSNotFound{
            return (false, Language.get("NON_DIGIT_PHONE_NUMBER_MESSAGE") )
        }
        
        return (true, "")
    }
    
    // validate password
    static func validate(password: String) -> ValidateResult{
        // validate password length
        if password.length == 0{
            return (false, Language.get("MISSING_PASSWORD_MESSAGE") )
        }
        
        if password.length < 6{
            return (false, Language.get("NOT_MEET_MINIMUM_PASSWORD_MESSAGE") )
        }
        
//        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()")
//        if password.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
//            return (false, Language.get("INVALID_PASSWORD_MESSAGE") )
//        }
        
        return (true, "")
    }
    
    // validate confirm password
    static func validate(confirmPassword: String, password: String) -> ValidateResult{
        // validate password length
        if confirmPassword.length == 0{
            return (false, Language.get("MISSING_CONFIRM_PASSWORD_MESSAGE") )
        }
        
        if confirmPassword.length < 6{
            return (false, Language.get("NOT_MEET_MINIMUM_PASSWORD_MESSAGE") )
        }
        
//        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()")
//        if confirmPassword.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
//            return (false, Language.get("INVALID_CONFIRM_PASSWORD_MESSAGE") )
//        }
        
        if confirmPassword != password {
            return (false, Language.get("NOT_MATCH_CONFIRM_PASSWORD_MESSAGE") )
        }
        
        return (true, "")
    }
    
    static func validate(email: String) -> ValidateResult{
        if email.length == 0{
            return (false, Language.get("MISSING_EMAIL_MESSAGE") )
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: email)
        if !isValid{
            return (false, Language.get("INVALID_EMAIL_MESSAGE") )
        }
        
        return (true, "")
    }
    
    static func validate(otpCode: String) -> ValidateResult{
        if otpCode.length != 6{
            return (false, Language.get("INVALID_OTP_CODE_MESSAGE") )
        }
        return (true , "")
    }
}
