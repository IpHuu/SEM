//
//  ProfileViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import Photos
import EMAlertController
private enum SectionProfile: Int{
    case Account,
    Personal,
    Contact
}

class ProfileViewController: BaseViewController {

    var interactor: ProfileInteractor!
    var router: ProfileRouter!
    
    var isEditProfile: Bool = false
    var isChangeInfo: Bool = false
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _icEdit: UIButton!
    
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var _imgBackgroundHeader: UIImageView!
    @IBOutlet weak var _imgAvatar: UIImageView!
    
    @IBOutlet weak var _tbView: UITableView!
    @IBOutlet weak var _btnCamera: UIButton!
    var imagePicker = UIImagePickerController()
    
    var pickOption = ["Nữ", "Nam", "Khác"]
    var infoEdit = CustomerObject()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        imagePicker.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        infoEdit = AuthenticationManager.sharedInstance.cachedCustomer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProfileConfiguator.sharedInstance.configure(viewController: self)
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Thông tin tài khoản"
        
        _imgAvatar.clipsToBounds = true
        _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.height/2
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.registerCellNib(cellClass: ProfileInfoCell.self)
        _tbView.registerCellNib(cellClass: ProfileEditCell.self)
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.register(UINib.init(nibName: "HeaderSectionTable", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSectionTable")
        _tbView.separatorStyle = .none
        _btnCamera.isHidden = !isEditProfile
        
        if !AuthenticationManager.sharedInstance.cachedCustomer.avatar.isEmpty{
            if AuthenticationManager.sharedInstance.cachedCustomer.avatar.isValidURL{
                let url = URL(string:AuthenticationManager.sharedInstance.cachedCustomer.avatar)
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self._imgAvatar.image = image
            }else{
                let url = URL(string:APIConstants.baseURLImage +  AuthenticationManager.sharedInstance.cachedCustomer.avatar)
                let data = NSData(contentsOf: url!)
                if data != nil {
                    let image = UIImage(data: data! as Data)
                    self._imgAvatar.image = image
                }
            }
        }
    }
    
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
    @IBAction func icEditProfilePressed(_ sender: Any) {
        isEditProfile = !isEditProfile
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime()
        groupAnimation.duration = 0.5
        groupAnimation.fillMode = kCAFillModeBoth
        
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = CGFloat(Double.pi)
        rotate.toValue = 0.0
        
        groupAnimation.animations = [rotate]
        
        _icEdit.layer.add(groupAnimation, forKey: nil)
        
        if isEditProfile {
            self._icEdit.setBackgroundImage(#imageLiteral(resourceName: "save"), for: .normal)
        }else{
            self._icEdit.setBackgroundImage(#imageLiteral(resourceName: "account_setting_edit"), for: .normal)
        }
        UIView.transition(with: self._btnCamera, duration: 0.3, options: [UIViewAnimationOptions.transitionFlipFromLeft], animations: {
            self._btnCamera.isHidden = !self.isEditProfile
        }, completion: nil)
        
        
        if isChangeInfo{
            let alert = EMAlertController(title: "SEM", message: "Bạn có muốn cập nhật thông tin không ?")
            let cancel = EMAlertAction(title: "Không", style: .cancel){
                self._tbView.reloadData()
            }
            let confirm = EMAlertAction(title: "Đồng ý", style: .normal) {
                self.interactor.updateProfile(avatar: self._imgAvatar.image!,
                                         name: self.infoEdit.name,
                                         email: self.infoEdit.email,
                                         address: self.infoEdit.address,
                                         gender: self.infoEdit.gender)
            }
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            self.isChangeInfo = false
        }else{
            _tbView.reloadData()
        }
        
        
    }
    
    func choosePhotoFromLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCameraPressed(_ sender: Any) {
        self.choosePhotoFromLibrary()
    }
    
    func animatedHeader(){
        self.headerHeightConstraint.constant = 120
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}
extension ProfileViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
        }else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 80 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100
            if self.headerHeightConstraint.constant < 80 {
                self.headerHeightConstraint.constant = 80
            }
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 120 {
            animatedHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 120 {
            animatedHeader()
        }
    }
}
extension ProfileViewController: ProfilePresenterOutput{
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
    func presentUpdateProfileSuccess(object: CustomerObject){
        self.showAlert(withMessage: "Cập nhật thành công")
        AuthenticationManager.sharedInstance.cachedCustomer = object
        _tbView.reloadData()
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSectionTable") as! HeaderSectionTable
        header.backgroundView?.backgroundColor = UIColor.white
        let sectionType = SectionProfile(rawValue: section)!
        
        switch sectionType {
        case .Account:
            header._lbTitle.text = "THÔNG TIN TÀI KHOẢN"
            return header
        case .Contact:
            header._lbTitle.text = "THÔNG TIN LIÊN LẠC"
            return header
        default:
            header._lbTitle.text = "THÔNG TIN CÁ NHÂN"
            return header
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SectionProfile(rawValue: section)!
        switch section {
        case .Account:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureProfileEditCell(tableView: tableView,at: indexPath)
    }
    func configureProfileInfoCell(tableView: UITableView ,at indexPath: IndexPath) -> ProfileInfoCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
        cell.selectionStyle = .none
        
        let section = SectionProfile(rawValue: indexPath.section)!
        switch section {
        case .Account:
            cell._lbTitle.text = "Mật khẩu"
        case .Personal:
            if indexPath.row == 0{ //Họ tên
                cell._lbTitle.text = "Họ tên:"
            }else if indexPath.row == 1{//Giới tính
                cell._lbTitle.text = "Giới Tính:"
            }else{
                cell._lbTitle.text = "Năm sinh:"
            }
        case .Contact:
            if indexPath.row == 0{ //Số điện thoại
                cell._lbTitle.text = "Số điện thoại:"
            }else if indexPath.row == 1{//Email
                cell._lbTitle.text = "Email:"
            }else{
                cell._lbTitle.text = "Địa chỉ:"
            }
        }
        
        
        return cell
    }
    
    func configureProfileEditCell(tableView: UITableView ,at indexPath: IndexPath) -> ProfileEditCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditCell") as! ProfileEditCell
        cell.selectionStyle = .none
        
        if !self.isEditProfile {
            cell._tfInput.borderStyle = .none
            cell._tfInput.isEnabled = false
        }else{
            cell._tfInput.borderStyle = .roundedRect
            cell._tfInput.isEnabled = true
        }
        cell._tfInput.delegate = self
        cell._tfInput.isSecureTextEntry = false
        let section = SectionProfile(rawValue: indexPath.section)!
        switch section {
        case .Account:
            cell._lbTitle.text = "Mật khẩu"
            cell._tfInput.isSecureTextEntry = true
            cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.password
            cell._tfInput.borderStyle = .none
            cell._tfInput.isEnabled = false
        case .Personal:
            if indexPath.row == 0{ //Họ tên
                cell._lbTitle.text = "Họ tên:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.name
                cell._tfInput.tag = 0
            }else if indexPath.row == 1{//Giới tính
                cell._lbTitle.text = "Giới Tính:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.getNameGender()
                let pickerView = UIPickerView()
                pickerView.delegate = self
                cell._tfInput.inputView = pickerView
                cell._tfInput.tag = 1
            }else{
                cell._lbTitle.text = "Năm sinh:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.createAt
                cell._tfInput.tag = 2
            }
        case .Contact:
            if indexPath.row == 0{ //Số điện thoại
                cell._lbTitle.text = "Số điện thoại:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.phone!
                cell._tfInput.borderStyle = .none
                cell._tfInput.isEnabled = false
                cell._tfInput.tag = 3
            }else if indexPath.row == 1{//Email
                cell._lbTitle.text = "Email:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.email
                cell._tfInput.tag = 4
            }else{
                cell._lbTitle.text = "Địa chỉ:"
                cell._tfInput.text = AuthenticationManager.sharedInstance.cachedCustomer.address
                cell._tfInput.tag = 5
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    static func from(info: [String : Any]) -> UIImage? {
        //        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        //            return image
        //        }
        
        var imageToBeReturned: UIImage?
        if let url = info[UIImagePickerControllerReferenceURL] as? URL,
            let asset = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: option, resultHandler: {(image: UIImage?, info: [AnyHashable : Any]?) in
                imageToBeReturned = image
            })
        }
        return imageToBeReturned
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //        if let selectedImage = UpdateInfoViewController.from(info: info) {
        //            self._imgAvatar.contentMode = .scaleAspectFit
        //            self._imgAvatar.image = selectedImage
        //        } else {
        //            print("Something went wrong")
        //        }
        
        var selectedImageFromImagePicker: UIImage?
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromImagePicker = image
        } else{
            print("Something went wrong")
        }
        
        dismiss(animated: true, completion: {
            self._imgAvatar.contentMode = .scaleAspectFill
            self._imgAvatar.image = selectedImageFromImagePicker
            self.isChangeInfo = true
        })
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //        navigationController.navigationBar.barTintColor = UIColor.redMainColor
        //        navigationController.navigationBar.isTranslucent = false
        //        navigationController.navigationBar.tintColor = UIColor.white
        //        navigationController.navigationBar.titleTextAttributes = [
        //            NSAttributedStringKey.foregroundColor : UIColor.white,
        //            NSAttributedStringKey.font: UIFont.fontOpenSans(style: .Regular, size: 20)
        //        ]
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension ProfileViewController: UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isChangeInfo = true
        if textField.tag == 0 { // họ tên
            infoEdit.name = textField.text!
        }else if textField.tag == 1{// Gioi tính
            if textField.text == "Nữ"{
                infoEdit.gender = 0
            }else if textField.text == "Nam"{
                infoEdit.gender = 1
            }else{
                infoEdit.gender = 2
            }
        }else if textField.tag == 2{// năm sinh
            
        }else if textField.tag == 4{// email
            infoEdit.email = textField.text!
        }else if textField.tag == 5{// địa chỉ
            infoEdit.address = textField.text!
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = IndexPath(row: 1, section: SectionProfile.Personal.rawValue)
        let cell = _tbView.cellForRow(at: indexPath) as! ProfileEditCell
        cell._tfInput.text = pickOption[row]
    }
}

