//
//  CreatePasswordViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import EMAlertController
class CreatePasswordViewController: BaseViewController {

    var interactor: CreatePasswordInteractor!
    var router: CreatePasswordRouter!
    
    
    @IBOutlet weak var _lbHeader: UILabel!
    
    @IBOutlet weak var _tfPassword: UITextField!
    @IBOutlet weak var _tfConfirmPassword: UITextField!
    
    @IBOutlet weak var _icShowPass: UIImageView!
    @IBOutlet weak var _icShowPassConfirm: UIImageView!
    @IBOutlet weak var _btnDone: UIButton!
    @IBOutlet weak var _viewForm: UIView!
    var objectOTP = OTPObject()
    var customerObj = CustomerObject()
    var typeConfirm: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        CreatePasswordConfiguator.sharedInstance.configure(viewController: self)
    }
    
    func initUI(){
        _viewForm.makeShadowRound()
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Tạo mật khẩu"
        
        _btnDone.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Hoàn tất đăng kí", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
        
        let tapGestureShowPass = UITapGestureRecognizer(target: self, action: #selector(tapIconShowPass))
        tapGestureShowPass.numberOfTapsRequired = 1
        tapGestureShowPass.numberOfTouchesRequired = 1
        _icShowPass.addGestureRecognizer(tapGestureShowPass)
        _icShowPass.isUserInteractionEnabled = true
        
        let tapGestureShowPassConfirm = UITapGestureRecognizer(target: self, action: #selector(tapIconShowPass))
        tapGestureShowPassConfirm.numberOfTapsRequired = 1
        tapGestureShowPassConfirm.numberOfTouchesRequired = 1
        _icShowPassConfirm.addGestureRecognizer(tapGestureShowPassConfirm)
        _icShowPassConfirm.isUserInteractionEnabled = true
        
        _tfPassword.placeholder = "Mật khẩu"
        _tfPassword.borderStyle = .none
        _tfPassword.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        _tfConfirmPassword.placeholder = "Xác nhận mật khẩu"
        _tfConfirmPassword.borderStyle = .none
        _tfConfirmPassword.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        _tfPassword.isSecureTextEntry = true
        _tfConfirmPassword.isSecureTextEntry = true
        self.hideKeyboardWhenTappedAround()
    }
    @objc func tapIconShowPass(gesture: UITapGestureRecognizer){
        if gesture.view == _icShowPass{
            self._tfPassword.isSecureTextEntry = !self._tfPassword.isSecureTextEntry
            if self._tfPassword.isSecureTextEntry == true {
                _icShowPass.image = #imageLiteral(resourceName: "hide_pass")
            }else{
                _icShowPass.image = #imageLiteral(resourceName: "show_pass")
            }
        }
        if gesture.view == _icShowPassConfirm{
            self._tfConfirmPassword.isSecureTextEntry = !self._tfConfirmPassword.isSecureTextEntry
            if self._tfConfirmPassword.isSecureTextEntry == true {
                _icShowPassConfirm.image = #imageLiteral(resourceName: "hide_pass")
            }else{
                _icShowPassConfirm.image = #imageLiteral(resourceName: "show_pass")
            }
        }
        
    }
    @IBAction func btnDonePressed(_ sender: Any) {
        if typeConfirm == 0 {
            customerObj.otpID = objectOTP.otpID!
            customerObj.password = _tfPassword.text!
            interactor.completionRegisterAccount(customer: customerObj,
                                                 confirmPassword: _tfConfirmPassword.text!)
        }else{
            interactor.completionRegisterForgotPassword(otpUUID: objectOTP.otpUUID,
                                                        password: _tfPassword.text!,
                                                        confirmPassword: _tfConfirmPassword.text!)
        }
        
        
        
    }
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
}
extension CreatePasswordViewController: CreatePasswordPresenterOutput{
    func presentLoading(_ isLoading: Bool){
        if isLoading{
            self.showLoading()
        }else{
            self.hideLoading()
        }
    }
    func presentAlert(message: String){
        self.showAlert(withMessage: message)
    }
    func presentError(error: APIError){
        self.showAlert(withMessage: error.message)
    }
    func presentRegisterSuccess(objectData: CustomerObject){
        let alert = EMAlertController(title: "SEM", message: "Đăng kí thành công. Bạn đã có thể đăng nhập với tài khoản vừa đăng kí")
        let confirm = EMAlertAction(title: "OK", style: .normal) {
            self.router.navigateToSignIn()
        }
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
    func presentForgotPasswordSuccess(){
        let alert = EMAlertController(title: "SEM", message: "Tạo mật khẩu thành công. Bạn đã có thể đăng nhập với tài khoản")
        let confirm = EMAlertAction(title: "OK", style: .normal) {
            self.router.navigateToSignIn()
        }
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
}
