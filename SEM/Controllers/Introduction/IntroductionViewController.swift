//
//  IntroductionViewController.swift
//  SEM
//
//  Created by Ipman on 12/17/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class IntroductionViewController:  BaseViewController{

    var interactor: IntroductionInteractor!
    var router: IntroductionRouter!
    @IBOutlet weak var _viewSlider: UIView!
    @IBOutlet weak var _btnSignIn: UIButton!
    @IBOutlet weak var _btnSignUp: UIButton!
    var imagesArray = [Any]()
    var slider : SBSliderView?
    
    
    @IBAction func btnSignInPressed(_ sender: Any) {
        router.navigateToSignIn()
    }
    @IBAction func btnSignUpPressed(_ sender: Any) {
        router.navigateToSignUp()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IntroductionConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initData()
    }
    
    func initUI(){
        _btnSignIn.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Đăng nhập", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
        _btnSignUp.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Đăng ký", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
    }
    func initData(){
        imagesArray.append(UIImage(named: "Banner1")!)
        imagesArray.append(UIImage(named: "Banner1")!)
        imagesArray.append(UIImage(named: "Banner1")!)
        slider = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        slider?.delegate = self
        self._viewSlider.addSubview(slider!)
        
        slider?.createSlider(withImages: imagesArray, withAutoScroll: true, in: self._viewSlider)
        slider?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(_viewSlider.frame.size.width), height: CGFloat(_viewSlider.frame.size.height))
    }
}
extension IntroductionViewController: IntroductionPresenterOutput{
    
}
extension IntroductionViewController: SBSliderDelegate{
    func sbslider(_ sbslider: SBSliderView, didTapOn targetImage: UIImage, andParentView targetView: UIImageView , andWithTag tag: Int) {
        //        print("\(tag)")
        //
        //        guard let url = URL(string: banner[tag].link) else {
        //            return //be safe
        //        }
        //
        //        if #available(iOS 10.0, *) {
        //            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //        } else {
        //            UIApplication.shared.openURL(url)
        //        }
    }
}
