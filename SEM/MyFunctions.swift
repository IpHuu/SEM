//
//  MyFunctions.swift
//  SEM
//
//  Created by Ipman on 12/28/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit
class MyFunctions: NSObject {
    static let sharedInstance = MyFunctions()
    
    static func refreshToken(completion: @escaping (Bool) -> Void){
        APIServices.refreshToken(token: AuthenticationManager.sharedInstance.catchToken.refreshToken){
            response in
            if let data = response.result.data{
                AuthenticationManager.sharedInstance.catchToken = data
                completion(true)
                return
            }
            if ErrorTokenType.ERR_TOKEN_REF_EXP.rawValue == response.result.error.code{
                completion(false)
                let name = NSNotification.Name(rawValue: "notiReloginAccount")
                NotificationCenter.default.post(name: name, object: self, userInfo: nil)
            }
        }
    }
    
    static func checkExsistDeviceInCart(device: DeviceObject) -> Bool{
        if AuthenticationManager.sharedInstance.cachedCartDevice.count <= 0{
            return false
        }
        for i in 0...AuthenticationManager.sharedInstance.cachedCartDevice.count - 1{
            let dict = AuthenticationManager.sharedInstance.cachedCartDevice[i]
            if device.id! == dict.id!{
                dict.increaseQuantity()
                AuthenticationManager.sharedInstance.cachedCartDevice[i] = dict
                return true
            }
        }
        return false
    }

    static func shakingView(tempView : UIView){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: tempView.center.x - 5, y: tempView.center.y)
        animation.toValue = CGPoint(x: tempView.center.x + 5, y: tempView.center.y)
        tempView.layer.add(animation, forKey: "position")
    }
    
    static func animationFlyToCart(addSubview view: UIView ,tempView: UIView, to toView: UIView, completion: @escaping ()-> Void)  {
        view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = toView.frame.origin.x
                tempView.frame.origin.y = toView.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 0.5 , animations: {
                    completion()
                    toView.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    toView.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
    static func flyProductDetailToCart(viewcontroller controller: UIViewController, from fromView: UIView, to toView: UIView){
        let bezierPath = UIBezierPath()
        bezierPath.move(to: fromView.center)
        bezierPath.addQuadCurve(to: toView.center, controlPoint: fromView.center)
        
        let moveAnim = CAKeyframeAnimation(keyPath: "position")
        moveAnim.path = bezierPath.cgPath
        moveAnim.isRemovedOnCompletion = true
        
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0))
        scaleAnim.isRemovedOnCompletion = true
        
        let opacityAnim = CABasicAnimation(keyPath: "alpha")
        opacityAnim.fromValue = NSNumber(value: 1.0)
        opacityAnim.toValue = NSNumber(value: 0.1)
        opacityAnim.isRemovedOnCompletion = true
        
        let animGroup = CAAnimationGroup()
        animGroup.delegate = controller as? CAAnimationDelegate
        animGroup.setValue("curvedAnim", forKey: "animationName")
        animGroup.animations = [moveAnim,scaleAnim,opacityAnim]
        animGroup.duration = 0.5
        fromView.layer.add(animGroup, forKey: "curvedAnim")
    }
}
