//
//  HomeViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
private enum SectionHome: Int{
    case camera,
    device,
    sos
}
class HomeViewController: BaseViewController {

    @IBOutlet weak var _imgAvatar: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbDetails: UILabel!
    @IBOutlet weak var _icNoti: UIImageView!
    @IBOutlet weak var _lbQtyNoti: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    @IBOutlet weak var _btnLogin: UIButton!
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    var interactor: HomeInteractor!
    var router: HomeRouter!
    override func awakeFromNib() {
        super.awakeFromNib()
        HomeConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self._icNoti.transform = CGAffineTransform(rotationAngle: 0.5)
        }, completion: { ( _ ) in
            self._icNoti.transform = CGAffineTransform(rotationAngle: 0.0)
        })
        
    }
    func initUI(){
        _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.height/2
        _imgAvatar.clipsToBounds = true

        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbDetails.font = UIFont.fontRoboto(style: .Light, size: 16)
        
        _lbQtyNoti.cornerRadius = _lbQtyNoti.frame.size.height / 2
        _lbQtyNoti.font = UIFont.fontRoboto(style: .Regular, size: 12)
        _lbQtyNoti.textColor = UIColor.white
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.registerCellNib(cellClass: DeviceRowCell.self)
        _tbView.registerCellNib(cellClass: ButtonSOSCell.self)
        _tbView.registerCellNib(cellClass: CameraMonitoringCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
        _tbView.separatorStyle = .none
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        header._lbMore.isUserInteractionEnabled = true
        
        let section = SectionHome(rawValue: section)!
        switch section {
        case .camera:
            header._lbTilte.text = "CAMERA"
            header._lbMore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMoreCamera)))
            return header
        case .device:
            header._lbTilte.text = "THIẾT BỊ"
            header._lbMore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMoreDevices)))
            return header
        default:
            return nil
        }
    }
    @objc func handleTapMoreDevices(){
        router.navigateToDevices()
    }
    @objc func handleTapMoreCamera(){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SectionHome(rawValue: indexPath.section)!
        switch section {
        case .camera:
            return configureCameraMonitoringCell(at: indexPath, in: tableView)
        case .device:
            return configureDeviceRowCell(at: indexPath, in: tableView)
        default:
            return configureButtonSOSCell(at: indexPath, in: tableView)
        }
        
    }
    func configureDeviceRowCell(at indexPath: IndexPath, in tableView: UITableView) -> DeviceRowCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceRowCell") as! DeviceRowCell
        cell.selectionStyle = .none
        return cell
    }
    func configureButtonSOSCell(at indexPath: IndexPath, in tableView: UITableView) -> ButtonSOSCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonSOSCell") as! ButtonSOSCell
        cell.selectionStyle = .none
        
        cell._btnSOS.addTarget(self, action: #selector(btnSOSPressed), for: .touchUpInside)
        return cell
    }
    
    @objc func btnSOSPressed(){
        router.navigateToSOS()
    }
    
    func configureCameraMonitoringCell(at indexPath: IndexPath, in tableView: UITableView) -> CameraMonitoringCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CameraMonitoringCell") as! CameraMonitoringCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sectionType = SectionHome(rawValue: indexPath.section)!
        
        switch sectionType {
        case .camera:
            return 310
        case .device:
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = _tbView.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            let countItem: CGFloat = 6
            var rowItem: CGFloat = 1
            if (countItem / itemsPerRow) >= 2 {
                rowItem = 2
            }
            return widthPerItem * rowItem + itemsPerRow * 10
        default:
            return 60
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionHome(rawValue: section)!
        
        switch sectionType {
        case .camera:
            return 40
        case .device:
            return 40
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionHome(rawValue: section)!
        
        switch sectionType {
        case .camera:
            return 10
        case .device:
            return 10
        default:
            return 0
        }
    }
}
extension HomeViewController: HomePresenterOutput{
    
}
