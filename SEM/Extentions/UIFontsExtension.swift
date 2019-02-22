//
//  UIFontsExtension.swift
//  SEM
//
//  Created by Ip Man on 12/17/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
enum FontStyle: String{
    case Light="Light",
    LightItalic="LightItalic",
    Regular="Regular",
    Black="Black",
    BlackItalic="BlackItalic",
    Medium="Medium",
    MediumItalic="MediumItalic",
    Italic = "Italic",
    Bold="Bold",
    BoldItalic = "BoldItalic",
    Thin="Thin",
    ThinItalic="ThinItalic"
}
extension UIFont{
    private static let FONT_ROBOTO_NAME = "Roboto"
    //MARK: Roboto
    static func fontRoboto(style:FontStyle, size:CFloat=17) -> UIFont{
        let font = UIFont(name: self.FONT_ROBOTO_NAME+"-"+style.rawValue, size: CGFloat(size))
        assert(font != nil, "Can't load font: \(style)")
        return font ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
}
