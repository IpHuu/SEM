//
//  SignUpViewController.swift
//  SEM
//
//  Created by Ipman on 12/17/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
enum TypeRegister: Int{
    case phone,
    social
}
class SignUpViewController: BaseViewController {
    var interactor: SignUpInteractor!
    var router: SignUpRouter!
    
    @IBOutlet weak var _viewHeader: UIView!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _icBack: UIButton!
    
    @IBOutlet weak var _viewForm: UIView!
    
    @IBOutlet weak var _tfName: UITextField!
    
    @IBOutlet weak var _tfEmail: UITextField!
    @IBOutlet weak var _tfPhone: UITextField!
    
    @IBOutlet weak var _btnSignUp: UIButton!
    @IBOutlet weak var _lbSignIn: UILabel!
    
    var typeRegister: Int = TypeRegister.phone.rawValue
    var social: SocialInfo!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        SignUpConfiguator.sharedInstance.configure(viewController: self)
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "ĐĂNG KÝ"
        _viewForm.makeShadowRound()
        
        _tfName.placeholder = "Họ và tên"
        _tfName.borderStyle = .none
        _tfName.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        _tfEmail.placeholder = "Email"
        _tfEmail.borderStyle = .none
        _tfEmail.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        _tfPhone.placeholder = "Số điện thoại"
        _tfPhone.borderStyle = .none
        _tfPhone.font = UIFont.fontRoboto(style: .Light, size: 17)
        
        if typeRegister == TypeRegister.social.rawValue {
            _tfName.text = "\(social.name)"
            _tfEmail.text = "\(social.email)"
        }
        
        _btnSignUp.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Đăng ký", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
        
        self.hideKeyboardWhenTappedAround()
        let myString = "Bạn đã có tài khoản? Đăng nhập ngay"
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont.fontRoboto(style: .Light, size: 16)])
        
        myMutableString.addAttribute(key: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue), value: UIColor.yellowMainColor, at: "Đăng nhập")
        
        _lbSignIn.attributedText = myMutableString
        _lbSignIn.isUserInteractionEnabled = true
        _lbSignIn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
    }
    @IBAction func icBackTapped(_ sender: Any) {
        router.gotoBack()
    }
    @IBAction func _btnSignUp(_ sender: Any) {
        if typeRegister == TypeRegister.social.rawValue {
            interactor.registerSendCodeOTPWithSocial(phone: _tfPhone.text!)
            return
        }
        interactor.registerSendCodeOTP(phone: _tfPhone.text!,
                                       name: _tfName.text!,
                                       email: _tfEmail.text!)
    }
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer){
        guard let text = _lbSignIn.attributedText?.string else {
            return
        }
        if text.range(of:"Đăng nhập") != nil {
            router.navigateToSignIn()
        }
    }
    

}
extension SignUpViewController: SignUpPresenterOutput{
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
    func presentRegisterSendCodeOTP(object: OTPObject){
        let customer = CustomerObject()
        customer.name = _tfName.text!
        customer.phone = _tfPhone.text!
        customer.email = _tfEmail.text!
        router.navigateToConfirmOTP(object: object, customer: customer)
    }
    func presentRegisterSendCodeOTPWithSocial(object: OTPObject){
        router.navigateToConfirmOTPWithSocial(social: social, otp: object)
    }
}
