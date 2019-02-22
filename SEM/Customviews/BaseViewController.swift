//
//  BaseViewController.swift
//  SEM
//
//  Created by IpMan on 4/13/17.
//  Copyright © 2017 IpMan. All rights reserved.
//

import UIKit
//import CoreLocation

class BaseViewController: UIViewController {

    var indicatorView: IndicatorView?
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
//        self.setNavigationbarStyle()
//        self.setBackButtonOnNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Loading HUD
    // showloading
    func showLoading(withMessage message: String?=nil){
        if indicatorView == nil{
            indicatorView = IndicatorView()
            indicatorView!.message = message
        }
        indicatorView!.show()
    }
    
    // hide loading
    func hideLoading() {
        if let indicatorView = indicatorView{
            UIView.animate(withDuration: 0.1){
                indicatorView.dismiss()
                self.indicatorView = nil
            }
        }
    }
}
