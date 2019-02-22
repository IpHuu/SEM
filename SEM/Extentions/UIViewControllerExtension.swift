//
//  UIViewControllerExtension.swift
//  lela
//
//  Created by Ip Man on 10/26/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
import EMAlertController
//import PopupDialog
//import MZFormSheetPresentationController
extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    // MARK: Alert view
    func showAlert(withMessage message: String, completion: (()->())? = nil){
        let alert = EMAlertController(title: "SEM", message: message)
        let cancel = EMAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    func showPopupAlert(title: String = "SEM",
                        message: String,
                        buttons: [EMAlertAction]){
        let alert = EMAlertController(title: title, message: message)
        for button in buttons{
            alert.addAction(button)
        }
        self.present(alert, animated: true, completion: nil)
    }
    func excute(afterDelay delay: Double, closure:@escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
struct AlertAction {
    func confirmButton(_ title: String = "Đồng ý", action: (()-> Void)? = nil) -> EMAlertAction{
        let button = EMAlertAction(title: title, style: .normal, action: action)
        return button
    }
    
    func cancelButton(_ title: String = "Hủy", action: (()-> Void)? = nil) -> EMAlertAction{
        let button = EMAlertAction(title: title, style: .cancel, action: action)
        return button
    }
}
