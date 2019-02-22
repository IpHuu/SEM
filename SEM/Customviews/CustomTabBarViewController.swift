//
//  CustomTabBarViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
private enum typeTab: Int {
    case Product
    case Service
    case Home
    case Setting
    case Account
}
class CustomTabBarViewController: UITabBarController {

    @IBOutlet weak var _viewTabBarCustom: UIView!
    
    @IBOutlet weak var _icProduct: UIImageView!
    @IBOutlet weak var _lbProduct: UILabel!
    @IBOutlet weak var _btnProduct: UIButton!
    
    @IBOutlet weak var _icService: UIImageView!
    @IBOutlet weak var _lbService: UILabel!
    @IBOutlet weak var _btnService: UIButton!
    
    @IBOutlet weak var _icHome: UIImageView!
    @IBOutlet weak var _btnHome: UIButton!
    
    @IBOutlet weak var _icSetting: UIImageView!
    @IBOutlet weak var _lbSetting: UILabel!
    @IBOutlet weak var _btnSetting: UIButton!
    
    @IBOutlet weak var _icAccount: UIImageView!
    @IBOutlet weak var _lbAccount: UILabel!
    @IBOutlet weak var _btnAccount: UIButton!
    
    
    var timer: Timer?
    var previousIndex: Int = 0
    @IBOutlet var tabBarView: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _viewTabBarCustom.frame = self.tabBarView.frame
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 { // iphone X
            _viewTabBarCustom.frame.origin.y = self.tabBarView.frame.origin.y - 35
            _viewTabBarCustom.frame.size.height = self.tabBarView.frame.size.height + 35
        }
        
        self.view.addSubview(_viewTabBarCustom)
        self.selectedIndex = 0; // Product tab active
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousIndex = self.selectedIndex
        self.highlightTabBarPressed(index: self.selectedIndex)
    }
    
    func setupUI(){
        let fonts: UIFont!
        fonts = UIFont.fontRoboto(style: .Light, size: 12)
        _lbProduct.font = fonts
        _lbAccount.font = fonts
        _lbService.font = fonts
        _lbSetting.font = fonts
        _lbProduct.textColor = UIColor.grayMainColor
        _lbAccount.textColor = UIColor.grayMainColor
        _lbService.textColor = UIColor.grayMainColor
        _lbSetting.textColor = UIColor.grayMainColor
        
    }
    @IBAction func handlerTapItemTabBar(_ sender: Any) {
        self.setDefaultTabBar(index: previousIndex)
        self.selectedIndex = (sender as! UIButton).tag
        self.highlightTabBarPressed(index: self.selectedIndex)
        previousIndex = self.selectedIndex
        
    }
    
    func highlightTabBarPressed(index: Int){
        let act = typeTab(rawValue: index)!
        switch act {
        case .Product:
            _icProduct.image = #imageLiteral(resourceName: "ic_product_act")
            bounceAnimation(imageView: _icProduct)
            _lbProduct.textColor = UIColor.blueMainColor
            break
        case .Service:
            _icService.image = #imageLiteral(resourceName: "ic_service_act")
            bounceAnimation(imageView: _icService)
            _lbService.textColor = UIColor.blueMainColor
            break
        case .Home:
            bounceAnimation(imageView: _icHome)
            //ic_home.image = #imageLiteral(resourceName: "home_active")
            break
        case .Setting:
            _icSetting.image = #imageLiteral(resourceName: "ic_setting_act")
            bounceAnimation(imageView: _icSetting)
            _lbSetting.textColor = UIColor.blueMainColor
            break
        case .Account:
            _icAccount.image = #imageLiteral(resourceName: "ic_account_act")
            bounceAnimation(imageView: _icAccount)
            _lbAccount.textColor = UIColor.blueMainColor
            break
        }
    }
    
    func setDefaultTabBar(index: Int) {
        let act = typeTab(rawValue: index)!
        switch act {
        case .Product:
            _icProduct.image = #imageLiteral(resourceName: "ic_product_def")
            _lbProduct.textColor = UIColor.grayMainColor
            break
        case .Service:
            _icService.image = #imageLiteral(resourceName: "ic_service_def")
            _lbService.textColor = UIColor.grayMainColor
            break
        case .Home:
            //ic_home.image = #imageLiteral(resourceName: "home_default")
            break
        case .Setting:
            _icSetting.image = #imageLiteral(resourceName: "ic_setting_def")
            _lbSetting.textColor = UIColor.grayMainColor
            break
        case .Account:
            _icAccount.image = #imageLiteral(resourceName: "ic_account_def")
            _lbAccount.textColor = UIColor.grayMainColor
            break
        }
    }
    

    func bounceAnimation(imageView: UIImageView) {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 0.3 * 2
        impliesAnimation.calculationMode = kCAAnimationCubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }

}
