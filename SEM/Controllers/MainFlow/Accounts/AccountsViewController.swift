//
//  AccountsViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import EMAlertController
private enum SectionAccount: Int{
    case setting,
    social,
    button
}
class AccountsViewController: BaseViewController {

    var interactor: AccountsInteractor!
    var router: AccountsRouter!
    
    @IBOutlet weak var _imgAvatar: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbDetails: UILabel!
    
    @IBOutlet weak var _tbView: UITableView!
    
    @IBOutlet weak var _btnLogin: UIButton!
    var Items: [ItemTable] = []
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        AccountsConfiguator.sharedInstance.configure(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initData()
    }
    func initUI(){
        
        _imgAvatar.clipsToBounds = true
        _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.height/2
        
        _lbName.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbDetails.font = UIFont.fontRoboto(style: .Light, size: 15)
        _lbName.textColor = UIColor.white
        _lbDetails.textColor = UIColor.white
        
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.registerCellNib(cellClass: AccountsCell.self)
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.register(UINib.init(nibName: "HeaderSectionTable", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSectionTable")
        _tbView.separatorStyle = .none
        Items.append(ItemTable(title:"Thông tin tài khoản", image:#imageLiteral(resourceName: "setting_account")))
        Items.append(ItemTable(title:"Quản lý cuộc hẹn", image:#imageLiteral(resourceName: "setting_appointment")))
        Items.append(ItemTable(title:"Quản lý đơn hàng", image:#imageLiteral(resourceName: "setting_order")))
        Items.append(ItemTable(title:"Cho phép thông báo", image:#imageLiteral(resourceName: "setting_notify")))
        Items.append(ItemTable(title:"Báo cáo sự cố", image:#imageLiteral(resourceName: "setting_report")))
        Items.append(ItemTable(title:"Pháp lý và chính sách", image:#imageLiteral(resourceName: "setting_policy")))
        Items.append(ItemTable(title:"Trợ giúp", image:#imageLiteral(resourceName: "setting_support")))
        _tbView.reloadData()
        
        
        if !AuthenticationManager.sharedInstance.isLoggedIn{
            _tbView.isHidden = true
            _btnLogin.isHidden = false
            _btnLogin.set(backgroundColor: UIColor.yellowMainColor, titleColor: UIColor.white, title: "Đăng nhập hoặc đăng ký", font: UIFont.fontRoboto(style: .Bold, size: 20))
            _btnLogin.layer.cornerRadius = 5.0
            _btnLogin.frame.size.width += 10.0
            _btnLogin.addTarget(self, action: #selector(tapBtnLogin), for: .touchUpInside)
        }
    }

    @objc func tapBtnLogin(){
        router.navigateToSignIn()
    }
    
    func initData(){
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
        }else{
            self._imgAvatar.image = #imageLiteral(resourceName: "logo_png")
        }
        
        _lbName.text = AuthenticationManager.sharedInstance.cachedCustomer.name
        _lbDetails.text = AuthenticationManager.sharedInstance.cachedCustomer.email
    }
}

extension AccountsViewController: AccountsPresenterOutput{
    
}
extension AccountsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSectionTable") as! HeaderSectionTable
        header.backgroundView?.backgroundColor = UIColor.white
        let sectionType = SectionAccount(rawValue: section)!
        
        switch sectionType {
        case .setting:
            header._lbTitle.text = "Cài đặt"
            return header
        case .social:
            header._lbTitle.text = "Liên kết"
            return header
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionAccount(rawValue: section)!
        
        switch sectionType {
        case .setting:
            return 40
        case .social:
            return 40
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section =  SectionAccount(rawValue: section)!
        switch section {
        case .setting:
            return Items.count
        case .social:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section =  SectionAccount(rawValue: indexPath.section)!
        switch section {
        case .setting:
            return configureAccountCellForSetting(tableView: tableView, at: indexPath)
        case .social:
            return configureAccountCellForSocial(tableView: tableView, at: indexPath)
        default:
            return configureButtonOneCell(tableView: tableView, at: indexPath)
        }
    }
    
    func configureAccountCellForSetting(tableView: UITableView ,at indexPath: IndexPath) -> AccountsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell") as! AccountsCell
        cell.selectionStyle = .none
        
        let dict = Items[indexPath.row]
        
        cell._lbCell.text = dict.title
        cell._icCell.image = dict.image
        
        if indexPath.row == 3{
//            let switchOnOff = UISwitch(frame: CGRect(x:cell.frame.size.width - 70, y: cell.frame.origin.y + (cell.frame.size.height-20)/2, width: 40, height: 20))
//
//            switchOnOff.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
//            switchOnOff.onTintColor = UIColor.blueMainColor
//            switchOnOff.tintColor = UIColor.blueMainColor
//            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
//            if isRegisteredForRemoteNotifications {
//                switchOnOff.setOn(true, animated: false)
//            } else {
//                switchOnOff.setOn(false, animated: false)
//            }
//
//            cell.addSubview(switchOnOff)
            
            let switch2 = CustomSwitch(frame: CGRect(x:cell.frame.size.width - 70, y: cell.frame.origin.y + (cell.frame.size.height-20)/2, width: 40, height: 20))
            switch2.onTintColor = UIColor.greenMainColor
            switch2.offTintColor = UIColor.darkGray
            switch2._cornerRadius = 0.1
            switch2.thumbCornerRadius = 0.1
            switch2.thumbTintColor = UIColor.white
            
            cell.addSubview(switch2)
        }
        
        return cell
    }
    func configureAccountCellForSocial(tableView: UITableView ,at indexPath: IndexPath) -> AccountsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell") as! AccountsCell
        cell.selectionStyle = .none
        
        if  indexPath.row == 0 {
            cell._lbCell.text = "Facebook"
            cell._icCell.image = #imageLiteral(resourceName: "ic_fb")
        }else{
            cell._lbCell.text = "Google"
            cell._icCell.image = #imageLiteral(resourceName: "ic_gg")
        }
        
        return cell
    }
    
    func configureButtonOneCell(tableView: UITableView ,at indexPath: IndexPath) -> ButtonOneCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonOneCell") as! ButtonOneCell
        cell.selectionStyle = .none
        
        cell._btnCell.set(backgroundColor: UIColor.blueMainColor, titleColor: UIColor.white, title: "Đăng xuất", font: UIFont.fontRoboto(style: .Bold, size: 20))
        cell._btnCell.layer.cornerRadius = 8.0
        cell._btnCell.addTarget(self, action: #selector(handlerLogout), for: .touchUpInside)
        return cell
    }
    @objc func handlerLogout(){
        let alert = EMAlertController(title: "SEM", message: "Bạn có muốn đăng xuất không ?")
        let cancel = EMAlertAction(title: "Không", style: .cancel)
        let confirm = EMAlertAction(title: "Đồng ý", style: .normal) {
            let name = NSNotification.Name(rawValue: "notiRootSignIn")
            NotificationCenter.default.post(name: name, object: self, userInfo: nil)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section =  SectionAccount(rawValue: indexPath.section)!
        switch section {
        case .setting: return 50
        case .social: return 50
        default: return 70
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section =  SectionAccount(rawValue: indexPath.section)!
        switch section {
        case .setting:
            if indexPath.row == 0 {
                router.navigateToEditProfile()
            }else if indexPath.row == 1{
                
            }
            else if indexPath.row == 2{
                router.navigateToListOrder()
            }else if indexPath.row == 4{
                router.navigateToSOS()
            }else if indexPath.row == 5{
                router.navigateToSupport(typeInfo: 0)// pháp lý và chính sách
            }else if indexPath.row == 6{
                router.navigateToSupport(typeInfo: 1)// hỗ trợ
            }
        case .social: break
        default: break
        }
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch){
        if (sender.isOn == true){
            print("UISwitch state is now ON")
        }
        else{
            print("UISwitch state is now Off")
        }
    }
    
}
