//
//  StringExtention.swift
//  lela
//
//  Created by Ip Man on 11/13/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
extension String{
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
    
    func width(withFont font: UIFont) -> CGFloat {
        let size: CGSize = self.size(withAttributes: [NSAttributedStringKey.font: font])
        return size.width
    }
//    static func getProductImagePath( name: String) -> String{
//        
//        return String(format: "%@%@",
//                      APIConstants.imgURL,
//                      name)
//    }
    func convertToDictionary() -> NSDictionary? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else { return nil }
        return html
    }
}
extension Double{
    var currencyString: String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.currencySymbol = "đ"
        formatter.decimalSeparator = ","
        formatter.numberStyle = .decimal

        var formattedString = ""
        if let convertedString = formatter.string(from: NSNumber(value: self)){
            formattedString = convertedString
        }else{
            formattedString = String(self)
        }

        return formattedString+" "+"đ"
    }
}
extension Int{
    var currencyString: String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.currencySymbol = "đ"
        formatter.decimalSeparator = ","
        formatter.numberStyle = .decimal
        
        var formattedString = ""
        if let convertedString = formatter.string(from: NSNumber(value: self)){
            formattedString = convertedString
        }else{
            formattedString = String(self)
        }
        
        return formattedString+" "+"đ"
    }
}

extension NSObject{
    func convertToShowFormatDate(dateString: String) -> String {
        
        if dateString.isEmpty {
            return dateString
        }
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd hh:mm:ss" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
}

