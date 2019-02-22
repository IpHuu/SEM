//
//  OrderDetailViewController.swift
//  SEM
//
//  Created by Ipman on 1/25/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
private enum SectionType: Int{
    case product,
    address,
    promotion,
    price,
    button
}
class OrderDetailViewController: BaseViewController {

    var interactor: OrderDetailInteractor!
    var router: OrderDetailRouter!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    var order: OrderObject!
    var orderDetail = OrderDetailObject()
    override func awakeFromNib() {
        super.awakeFromNib()
        OrderDetailConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.registerCellNib(cellClass: TableOrderCell.self)
        _tbView.registerCellNib(cellClass: InfoCell.self)
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.registerCellNib(cellClass: InfoPriceCell.self)
        _tbView.separatorStyle = .none
        _tbView.register(UINib.init(nibName: "HeaderSectionTableOrderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSectionTableOrderView")
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.getOrderDetail(idOrder: order.id!)
    }
    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension OrderDetailViewController: OrderDetailPresenterOutput{
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
    func presentOrderDetail(object: OrderDetailObject){
        self.orderDetail = object
        _tbView.reloadData()
    }
}
extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let typesection = SectionType(rawValue: section)!
        switch typesection {
        case .product:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSectionTableOrderView") as! HeaderSectionTableOrderView
            if orderDetail.info.id != nil && orderDetail.info.status != nil {
                header._lbCodeOrder.text = "Mã đơn hàng: \(orderDetail.info.id!)"
                header.updateStatus(status: orderDetail.info.status!)
            }
            
            return header
        case .address, .promotion:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
            header._lbMore.isHidden = true
            if section == SectionType.address.rawValue {
                header._lbTilte.text = "Phương thức giao hàng"
            }else{
                header._lbTilte.text = "Khuyến mãi & Ưu đãi"
            }
            return header
        default:
            return nil
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = SectionType(rawValue: section)!
        switch section {
        case .button, .price:
            return 0.1
        case .product:
            return 60
        default:
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = SectionType(rawValue: section)!
        switch section {
        case .button, .price:
            return 0.1
        default:
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SectionType(rawValue: section)!
        switch section {
        case .product:
            return orderDetail.listProduct.count
        case .address:
            return 4
        case .promotion:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SectionType(rawValue: indexPath.section)!
        switch section {
        case .product:
            return configureTableOrderCell(at: indexPath, in: tableView)
        case .price:
            return configureInfoPriceCell(at: indexPath, in: tableView)
        case .button:
            return configureButtonOneCell(at: indexPath, in: tableView)
        default:
            return configureInfoCell(at: indexPath, in: tableView)
        }
    }
    
    func configureTableOrderCell(at indexPath: IndexPath, in tableView: UITableView) -> TableOrderCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableOrderCell") as! TableOrderCell
        cell.selectionStyle = .none
        
        let dict = orderDetail.listProduct[indexPath.row]
        
        cell._imgProduct.sd_setImage(with: URL(string: APIConstants.baseURLImage + dict.img), placeholderImage: #imageLiteral(resourceName: "logo_png"))
        cell._lbDescription.text = dict.description
        cell._lbName.text = dict.name
        cell._lbQuantity.text = "x\(dict.quantity)"
        
        return cell
    }
    
    func configureInfoCell(at indexPath: IndexPath, in tableView: UITableView) -> InfoCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.selectionStyle = .none
        
        if indexPath.section == SectionType.address.rawValue{
            if indexPath.row == 0 {
                cell._lbTitle.text = "Địa chỉ giao hàng:"
                cell._lbContent.text = orderDetail.info.addressReceive
            }else if indexPath.row == 1{
                cell._lbTitle.text = "Giao hàng:"
                cell._lbContent.text = "\(orderDetail.info.nameShipment) - \(orderDetail.info.priceShipment.currencyString)"
            }else if indexPath.row == 2{
                cell._lbTitle.text = "Hình thức thanh toán:"
                cell._lbContent.text = orderDetail.info.namePayment
            }else{
                cell._lbTitle.text = "Thời gian"
                cell._lbContent.text = convertToShowFormatDate(dateString: orderDetail.info.createdAt)
            }
        }
        
        if indexPath.section == SectionType.promotion.rawValue{
            if indexPath.row == 0{
                cell._lbTitle.text = "Mã khuyến mãi:"
                cell._lbContent.text = orderDetail.info.discount
            }else{
                cell._lbTitle.text = "Giảm giá:"
                cell._lbContent.text = orderDetail.info.priceDiscount.currencyString
            }
        }
        
        return cell
    }
    
    func configureButtonOneCell(at indexPath: IndexPath, in tableView: UITableView) -> ButtonOneCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonOneCell") as! ButtonOneCell
        cell.selectionStyle = .none
        cell._btnCell.set(backgroundColor: UIColor.redMainColor, titleColor: UIColor.white, title: "Hủy đơn hàng", font: UIFont.fontRoboto(style: .Bold, size: 20))
        cell._btnCell.layer.cornerRadius = 5.0
        return cell
    }
    
    func configureInfoPriceCell(at indexPath: IndexPath, in tableView: UITableView) -> InfoPriceCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPriceCell") as! InfoPriceCell
        cell.selectionStyle = .none
        
        cell._lbRest.text = orderDetail.info.total.currencyString
        cell._lbAmount.text = orderDetail.info.subTotal.currencyString
        cell._lbSaleoff.text = (orderDetail.info.subTotal - orderDetail.info.total).currencyString
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = SectionType(rawValue: indexPath.section)!
        switch section {
        case .product:
            return 90
        case .price:
            return 100
        case .button:
            return 70
        default:
            return 60
        }
    }
}

