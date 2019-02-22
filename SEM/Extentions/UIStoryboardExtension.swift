//
//  UIStoryboardExtension.swift
//  lela
//
//  Created by Ip Man on 10/25/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import SwiftyExtension
enum StoryboardName: String{
    case Main="Main", Login="Login", Products="Products", Services="Services"
}
extension UIStoryboard{
    
    static func storyboard(name: StoryboardName) -> UIStoryboard{
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
    
    func viewController(aClass: AnyClass) -> UIViewController{
        return self.instantiateViewController(withIdentifier: String.className(aClass: aClass))
    }
    
}
