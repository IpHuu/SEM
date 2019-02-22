//
//  SignInViewController.swift
//  SEM
//
//  Created by Ipman on 12/17/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import EMAlertController
class SignInViewController: BaseViewController {
    
    @IBOutlet weak var _viewHeader: UIView!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _icBack: UIButton!

    @IBOutlet weak var _viewForm: UIView!
    
    @IBOutlet weak var _tfUsername: UITextField!
    @IBOutlet weak var _tfPassword: UITextField!
    @IBOutlet weak var _lbForgorPassword: UILabel!
    
    @IBOutlet weak var _btnSignIn: UIButton!
    @IBOutlet weak var _lbMore: UILabel!

    @IBOutlet weak var _lbRegister: UILabel!
    @IBOutlet weak var _icShowPass: UIImageView!
    @IBOutlet weak var _btnNoLogin: UIButton!
    
    
    var interactor: SignInInteractor!
    var router: SignInRouter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        SignInConfiguator.sharedInstance.configure(viewController: self)
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "ĐĂNG NHẬP"
        _viewForm.makeShadowRound()
        
        _tfUsername.placeholder = "Email/Số điện thoại"
        _tfUsername.borderStyle = .none
        _tfUsername.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        _tfPassword.placeholder = "Mật khẩu"
        _tfPassword.borderStyle = .none
        _tfPassword.font = UIFont.fontRoboto(style: .Light, size: 17)
        _tfPassword.isSecureTextEntry = true
        
        _lbForgorPassword.font = UIFont.fontRoboto(style: .Light, size: 15)
        _lbForgorPassword.text = "Quên mật khẩu ?"
        
        _lbForgorPassword.isUserInteractionEnabled = true
        _lbForgorPassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapForgotPassword)))
        
        
        _btnSignIn.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Đăng nhập", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
        _lbMore.font = UIFont.fontRoboto(style: .Light, size: 16)
        
        _btnNoLogin.set(backgroundColor: UIColor.clear, titleColor: UIColor.yellowMainColor, title: "Bỏ qua", font: UIFont.fontRoboto(style: .Bold, size: 19))
        
        self.hideKeyboardWhenTappedAround()
        let myString = "Bạn chưa có tài khoản? Đăng kí ngay"
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont.fontRoboto(style: .Light, size: 16)])
        
        myMutableString.addAttribute(key: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue), value: UIColor.yellowMainColor, at: "Đăng kí")
        
        _lbRegister.attributedText = myMutableString
        _lbRegister.isUserInteractionEnabled = true
        _lbRegister.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
        
        let tapGestureShowPass = UITapGestureRecognizer(target: self, action: #selector(tapIconShowPass))
        tapGestureShowPass.numberOfTapsRequired = 1
        tapGestureShowPass.numberOfTouchesRequired = 1
        _icShowPass.addGestureRecognizer(tapGestureShowPass)
        _icShowPass.isUserInteractionEnabled = true
    }
    @objc func handleTapForgotPassword(){
        let alert = EMAlertController.init(icon: #imageLiteral(resourceName: "logo"), title: "SEM - Quên mật khẩu", message: "Vui lòng nhập số điện thoại")
        alert.addTextField{
            (textField) in
            textField?.placeholder = "Nhập số điện thoại..."
            textField?.keyboardType = .numberPad
        }
        alert.titleColor = UIColor.yellowMainColor
        alert.messageColor = UIColor.redMainColor
        alert.dataDetectorTypes = .all
        alert.isMessageSelectable = true
        let cancel = EMAlertAction(title: "Bỏ qua", style: .cancel)
        cancel.titleFont = UIFont.fontRoboto(style: .Bold, size: 18)
        cancel.titleColor = UIColor.redMainColor
        let confirm = EMAlertAction(title: "OK", style: .normal){
            guard let phone = alert.textFields.first?.text else { return }
            self.interactor.registerForgotPassword(phone: phone)
        }
        confirm.titleFont = UIFont.fontRoboto(style: .Bold, size: 18)
        confirm.titleColor = UIColor.yellowMainColor
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    @objc func tapIconShowPass(gesture: UITapGestureRecognizer){
        self._tfPassword.isSecureTextEntry = !self._tfPassword.isSecureTextEntry
        if self._tfPassword.isSecureTextEntry == true {
            _icShowPass.image = #imageLiteral(resourceName: "hide_pass")
        }else{
            _icShowPass.image = #imageLiteral(resourceName: "show_pass")
        }
    }
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer){
        guard let text = _lbRegister.attributedText?.string else {
            return
        }
        if text.range(of:"Đăng kí") != nil {
            router.navigateToSignUp()
        }
    }
    @IBAction func icBackTapped(_ sender: Any) {
        router.gotoBack()
    }
    @IBAction func btnNoLoginPressed(_ sender: Any) {
        router.navigateToHome()
    }
    @IBAction func _btnSignIn(_ sender: Any) {
        interactor.loginAccount(username: _tfUsername.text!, password: _tfPassword.text!)
//        router.navigateToHome()
    }
    @IBAction func btnFBPressed(_ sender: Any) {
    }
    
    @IBAction func btnGGPressed(_ sender: Any) {
        interactor.loginWithGoogle(viewController: self)
    }
}
extension SignInViewController: SignInPresenterOutput{
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
    func presentLoginSuccess(token: TokenObject){
        AuthenticationManager.sharedInstance.catchToken = token
        interactor.getMe()
    }
    func presentFetchCustomer(object: CustomerObject){
        AuthenticationManager.sharedInstance.isLoggedIn = true
        AuthenticationManager.sharedInstance.cachedCustomer = object
        router.navigateToHome()
    }
    func presentRegisterForgotPassword(otp: OTPObject){
        router.navigateToConfirmCodeOTP(objectOTP: otp)
    }
    func presentUpdatePhoneWithLoginSocial(social: SocialInfo){
        router.navigateToSignUpWithSocial(social: social)
    }
}
