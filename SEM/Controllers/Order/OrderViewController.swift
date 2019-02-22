//
//  OrderViewController.swift
//  SEM
//
//  Created by Ipman on 1/15/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
private enum SectionType: Int{
    case infoCustomer,
    address,
    time,
    payment,
    price,
    button
}
class OrderViewController: BaseViewController {

    var interactor: OrderInteractor!
    var router: OrderRouter!
    
    var selectedIndex:Int = 0
    var listPayment = [PaymentObject]()
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    var orderObject = OrderObject()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getListPayment()
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _lbHeader.text =  "Xác nhận mua hàng"
        
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.registerCellNib(cellClass: PaymentRadioCell.self)
        _tbView.registerCellNib(cellClass: InforReceiverCell.self)
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.estimatedRowHeight = 40
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
        _tbView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        OrderConfiguator.sharedInstance.configure(viewController: self)
    }
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
    
}
extension OrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        header._lbMore.isUserInteractionEnabled = true
        header._lbMore.isHidden = true
        let section = SectionType(rawValue: section)!
        switch section {
        case .infoCustomer:
            header._lbTilte.text = "Thông người người nhận"
        case .address:
            header._lbTilte.text = "Địa chỉ giao hàng"
        case .time:
            header._lbTilte.text = "Thời gian dự kiến"
        case .payment:
            header._lbTilte.text = "Hình thức thanh toán"
        case .price:
            header._lbTilte.text = "Giá trị đơn hàng"
            header._lbMore.isHidden = false
            header._lbMore.text = orderObject.total.currencyString
            header._lbMore.font = UIFont.fontRoboto(style: .Bold, size: 18)
            header._lbMore.textColor = UIColor.redMainColor
        default:
            return nil
        }
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .button:
            return 0.1
        default:
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .price:
            return 0.1
        case .button:
            return 0.1
        default:
            return 10
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .payment:
            return listPayment.count
        case .price:
            return 0
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .payment:
            return configurePaymentRadioCell(at: indexPath, in: tableView)
        case .button:
            return configureButtonOneCell(at: indexPath, in: tableView)
        case .infoCustomer:
            return configureInforReceiverCell(at: indexPath, in: tableView)
        default:
            return configureTableViewCell(at: indexPath, in: tableView)
        }
        
        
    }
    func configureTableViewCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont.fontRoboto(style: .Regular, size: 16)
        cell.textLabel?.numberOfLines = 0
        
        let sectionType = SectionType(rawValue: indexPath.section)!
        switch sectionType {
        case .address:
            cell.textLabel?.text = orderObject.addressReceive
        case .time:
            cell.textLabel?.text = "Thời gian giao hàng"
        default:
            break
        }
        
        
        return cell
    }
    func configureButtonOneCell(at indexPath: IndexPath, in tableView: UITableView) -> ButtonOneCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonOneCell") as! ButtonOneCell
        cell.selectionStyle = .none
        
        cell._btnCell.setBackgroundImage(#imageLiteral(resourceName: "buy_button"), for: .normal)
        cell._btnCell.set(backgroundColor: UIColor.clear, titleColor: UIColor.white, title: "XÁC NHẬN ĐẶT HÀNG", font: UIFont.fontRoboto(style: .Bold, size: 20))
        cell._btnCell.addTarget(self, action: #selector(tapBtnOrderConfirm), for: .touchUpInside)
        
        return cell
    }
    @objc func tapBtnOrderConfirm(){
        if listPayment.count > 0 {
            orderObject.idPayment = listPayment[selectedIndex].id!
        }
        interactor.createOrder(order: orderObject)
    }
    func configureInforReceiverCell(at indexPath: IndexPath, in tableView: UITableView) -> InforReceiverCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InforReceiverCell") as! InforReceiverCell
        cell.selectionStyle = .none
        
        cell._tfName.tag = 0
        cell._tfName.delegate = self
        cell._tfPhone.tag = 1
        cell._tfPhone.delegate = self
        cell._tfPhone.keyboardType = .numberPad
        cell._tfEmail.tag = 2
        cell._tfEmail.delegate = self
        
        cell._tfName.text = AuthenticationManager.sharedInstance.cachedCustomer.name
        orderObject.nameCustomer = AuthenticationManager.sharedInstance.cachedCustomer.name
        cell._tfPhone.text = AuthenticationManager.sharedInstance.cachedCustomer.phone == nil ? "" : AuthenticationManager.sharedInstance.cachedCustomer.phone
        orderObject.phoneCustomer = AuthenticationManager.sharedInstance.cachedCustomer.phone == nil ? "" : AuthenticationManager.sharedInstance.cachedCustomer.phone!
        cell._tfEmail.text = AuthenticationManager.sharedInstance.cachedCustomer.email
        orderObject.emailCustomer = AuthenticationManager.sharedInstance.cachedCustomer.email
        
        return cell
    }
    
    func configurePaymentRadioCell(at indexPath: IndexPath, in tableView: UITableView) -> PaymentRadioCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentRadioCell") as! PaymentRadioCell
        cell.selectionStyle = .none
        
        let dict = listPayment[indexPath.row]
        cell._lbTitle.text = dict.name
        cell._lbDescription.text = dict.description
        
        cell.isSelected = selectedIndex == indexPath.row ? true : false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == SectionType.payment.rawValue {
            selectedIndex = indexPath.row
            _tbView.beginUpdates()
            _tbView.reloadSections(IndexSet(integer: SectionType.payment.rawValue), with: .none)
            _tbView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .payment:
            return 80
        case .button:
            return 70
        case .infoCustomer:
            return 200
        default:
            return 44
        }
    }
}

extension OrderViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 { // name
            orderObject.nameCustomer = textField.text!
        }else if textField.tag == 1{ // phone
            orderObject.phoneCustomer = textField.text!
        }else if textField.tag == 2{ // email
            orderObject.emailCustomer = textField.text!
        }
    }
}
extension OrderViewController: OrderPresenterOutput{
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
    func presentListPayment(payments: [PaymentObject]){
        self.listPayment = payments
        _tbView.beginUpdates()
        _tbView.reloadSections(IndexSet(integer: SectionType.payment.rawValue), with: .none)
        _tbView.endUpdates()
    }
    func presentCreateOrderSuccess(){
        self.showAlert(withMessage: "Tạo đơn hàng thành công")
    }
}
