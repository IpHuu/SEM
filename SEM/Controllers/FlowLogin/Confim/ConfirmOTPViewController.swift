//
//  ConfirmOTPViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import EMAlertController
enum TypeConfirm: Int{
    case register,
    forgotPassword,
    registerSocial
}
class ConfirmOTPViewController: BaseViewController {

    var interactor: ConfirmOTPInteractor!
    var router: ConfirmOTPRouter!
    
    @IBOutlet weak var _view1: UIView!
    @IBOutlet weak var _view2: UIView!
    @IBOutlet weak var _view3: UIView!
    @IBOutlet weak var _view4: UIView!
    @IBOutlet weak var _view5: UIView!
    @IBOutlet weak var _view6: UIView!
    
    @IBOutlet weak var _tf1: UITextField!
    @IBOutlet weak var _tf2: UITextField!
    @IBOutlet weak var _tf3: UITextField!
    @IBOutlet weak var _tf4: UITextField!
    @IBOutlet weak var _tf5: UITextField!
    @IBOutlet weak var _tf6: UITextField!
    
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _icBack: UIButton!
    @IBOutlet weak var _lbRequestCode: UILabel!
    @IBOutlet weak var _lbIntro: UILabel!
    @IBOutlet weak var _btnConfirm: UIButton!

    var objectOTP = OTPObject()
    var customerObj = CustomerObject()
    
    var stringOTP: String = ""
    var typeConfirm: Int = TypeConfirm.register.rawValue
    var social: SocialInfo!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    func initUI(){
        _tf1.delegate = self
        _tf2.delegate = self
        _tf3.delegate = self
        _tf4.delegate = self
        _tf5.delegate = self
        _tf6.delegate = self
        
        _tf1.keyboardType = .numberPad
        _tf2.keyboardType = .numberPad
        _tf3.keyboardType = .numberPad
        _tf4.keyboardType = .numberPad
        _tf5.keyboardType = .numberPad
        _tf6.keyboardType = .numberPad
        
        _tf1.becomeFirstResponder()
        
        _view1.makeShadowRound()
        _view2.makeShadowRound()
        _view3.makeShadowRound()
        _view4.makeShadowRound()
        _view5.makeShadowRound()
        _view6.makeShadowRound()
        
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Xác nhận"
        
        _lbIntro.font =  UIFont.fontRoboto(style: .Light, size: 16)
        _lbIntro.text = "Vui lòng nhập mã xác nhận SMS mà chúng tôi gửi qua số điện thoại"
        let myString = "Bạn không nhận được mã? Gửi lại"
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont.fontRoboto(style: .Light, size: 14)])
        
        myMutableString.addAttribute(key: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue), value: UIColor.yellowMainColor, at: "Gửi lại")
        
        _lbRequestCode.attributedText = myMutableString
        _lbRequestCode.isUserInteractionEnabled = true
        _lbRequestCode.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
        
        _btnConfirm.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Xác nhận", font: UIFont.fontRoboto(style: .Bold, size: 20), cornerRadius: 10)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer){
        guard let text = _lbRequestCode.attributedText?.string else {
            return
        }
        if let range = text.range(of:"Gửi lại") {
            print(range)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ConfirmOTPConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        typeConfirm = TypeConfirm.register.rawValue
    }
    
    
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
    
    @IBAction func _btnConfirm(_ sender: Any) {
        stringOTP = "\(_tf1.text!)\(_tf2.text!)\(_tf3.text!)\(_tf4.text!)\(_tf5.text!)\(_tf6.text!)"
        interactor.confirmCodeOTP(otpCode: stringOTP, otpId: objectOTP.otpID!)
    }
}

extension ConfirmOTPViewController: ConfirmOTPPresenterOutput{
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
    func presentConfirmOTPSuccess(otp: OTPObject){
        if typeConfirm == TypeConfirm.registerSocial.rawValue {
            interactor.registerSocial(social: social, otp: otp)
            return
        }
        router.navigateToCreatePassword(object: otp, customer: customerObj, type: typeConfirm)
    }
    
    func presentRegisterSocialSuccess(token: TokenObject){
        AuthenticationManager.sharedInstance.catchToken = token
        interactor.getMe()
    }
    func presentFetchCustomer(object: CustomerObject){
        AuthenticationManager.sharedInstance.isLoggedIn = true
        AuthenticationManager.sharedInstance.cachedCustomer = object
        
        let alert = EMAlertController(title: "SEM", message: "Đăng kí thành công!")
        let confirm = EMAlertAction(title: "OK", style: .normal) {
            self.router.navigateToHome()
        }
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
        
    }
}
extension ConfirmOTPViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if((textField.text?.count)! < 1) && (string.count > 0){
            if (textField == _tf1){
                _tf2.becomeFirstResponder()
            }
            if (textField == _tf2){
                _tf3.becomeFirstResponder()
            }
            if (textField == _tf3){
                _tf4.becomeFirstResponder()
            }
            if (textField == _tf4){
                _tf5.becomeFirstResponder()
            }
            if (textField == _tf5){
                _tf6.becomeFirstResponder()
            }
            if (textField == _tf6){
                _tf6.resignFirstResponder()
            }
            
            textField.text = string
            return false
        }else if ((textField.text?.count)! >= 1) && (string.count == 0){
            if textField == _tf2 {
                _tf1.becomeFirstResponder()
            }
            if textField == _tf3 {
                _tf2.becomeFirstResponder()
            }
            if textField == _tf4 {
                _tf3.becomeFirstResponder()
            }
            if textField == _tf5 {
                _tf4.becomeFirstResponder()
            }
            if textField == _tf6 {
                _tf5.becomeFirstResponder()
            }
            if textField == _tf1 {
                _tf1.resignFirstResponder()
            }
            textField.text = ""
            return false
        }else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
}
