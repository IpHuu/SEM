//
//  CartsViewController.swift
//  SEM
//
//  Created by Ipman on 1/4/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import SDWebImage
import GooglePlaces
import EMAlertController
private enum SectionType: Int{
    case product,
    method,
    promotion,
    price,
    button
}
private enum PromotionType: Int{
    case money,
    percent,
    ship
    
}
class CartsViewController: BaseViewController {

    var interactor: CartsInteractor!
    var router: CartsRouter!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    
    var placeResultVC: PlacesSearchViewController!
    var locationManager = CLLocationManager()
    var listDevice = [DeviceObject]()
    var listShipment = [ShipmentObject]()
    var priceSaleOff: Double = 0
    var priceAmount: Double = 0
    var orderObject = OrderObject()
    var promotionObject = PromotionObject()
    override func awakeFromNib() {
        super.awakeFromNib()
        CartsConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAutocompleteView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        dismissAutoCompleteResult()
    }
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Giỏ hàng"
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.registerCellNib(cellClass: CartProductCell.self)
        _tbView.registerCellNib(cellClass: MethodReceiveCell.self)
        _tbView.registerCellNib(cellClass: CodePromotionCell.self)
        _tbView.registerCellNib(cellClass: InfoPriceCell.self)
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listDevice = AuthenticationManager.sharedInstance.cachedCartDevice
        interactor.getListShipment()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AuthenticationManager.sharedInstance.cachedCartDevice = listDevice
    }
    
    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupAutocompleteView(){
        if placeResultVC == nil{
            placeResultVC = PlacesSearchViewController()
            placeResultVC.delegate = self
            self.addChildViewController(placeResultVC)
            let addressCell = self.view.viewWithTag(1000) as! MethodReceiveCell
            var frame = CGRect.zero
            frame.origin = CGPoint(x: 20, y: addressCell.y +  addressCell._tfAddress.frame.maxY + 8)
            frame.size.width = self.view.width - 40
            frame.size.height = 0
            placeResultVC.view.frame = frame
            placeResultVC.view.makeBorderRound()
            placeResultVC.view.layer.cornerRadius = 10.0
            placeResultVC.view.alpha = 0
            self._tbView.addSubview(placeResultVC.view)
            placeResultVC.didMove(toParentViewController: self)
        }
        
    }
    
    func showAutoCompleteResult(){
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
            self.placeResultVC.view.alpha = 1
            var frame = self.placeResultVC.view.frame
            frame.size.height = 40*2
            self.placeResultVC.view.frame = frame
            self.view.layoutIfNeeded()
        }) { (_) in
        }
    }
    
    func dismissAutoCompleteResult(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            var frame = self.placeResultVC.view.frame
            frame.size.height = 0
            self.placeResultVC.view.frame = frame
        }) { (_) in
            self.placeResultVC.view.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}
extension CartsViewController: PlacesSearchViewControllerDelegate{
    func didSelectedSearchPlace(place: GGPredictionObject) {
        let cell = self._tbView.cellForRow(at: IndexPath(row: 0, section: SectionType.method.rawValue)) as! MethodReceiveCell
        cell._tfAddress.text = place.description
        orderObject.addressReceive = place.description
        self.dismissAutoCompleteResult()
    }
}
extension CartsViewController: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        guard let textFieldAddress = self.view.viewWithTag(1000) as? UITextField else { return }
        
        textFieldAddress.text = place.formattedAddress!
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension CartsViewController: CartsPresenterOutput{
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
    func presentListShipment(list: [ShipmentObject]){
        listShipment = list
        _tbView.reloadSections(IndexSet(integer: SectionType.method.rawValue), with: .none)
    }
    func presentSearch(placesPrediction: [GGPredictionObject]){
        showAutoCompleteResult()
        self.placeResultVC.reloadData(listPlace: placesPrediction)
    }
    func presentCheckCodePromotion(object: PromotionObject){
        promotionObject = object
        _tbView.beginUpdates()
        _tbView.reloadSections(IndexSet(integer: SectionType.price.rawValue), with: .none)
        _tbView.endUpdates()
    }
}

extension CartsViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MethodReceiveCellDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        header._lbMore.isHidden = true
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .product:
            
            header._lbTilte.text = "Danh sách sản phẩm"
            return header
        case .method:
            header._lbTilte.text = "Phương thức giao hàng"
            return header
        case .promotion:
            header._lbTilte.text = "Khuyến mãi và Ưu đãi"
            return header
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .product:
            return 40
        case .method:
            return 40
        case .promotion:
            return 40
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .product:
            return 10
        case .method:
            return 10
        case .promotion:
            return 10
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .product:
            return listDevice.count
        default:
            return 1
        }
    }
    func configureCartProductCell(at indexPath: IndexPath, in tableView: UITableView) -> CartProductCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell") as! CartProductCell
        cell.selectionStyle = .none
        
        if listDevice.count > 0{
            let dict = listDevice[indexPath.row]
            cell._imgProduct.sd_setImage(with: URL(string: APIConstants.baseURLImage + dict.img), placeholderImage: #imageLiteral(resourceName: "logo_png"))
            cell._lbName.text = dict.name
            cell._lbDescription.text = dict.description
            cell._lbPrice.text = dict.salePrice.currencyString
            cell._tfQuantity.text = String(dict.quantity)
            cell._btnIncrease.tag = indexPath.row
            cell._btnReduction.tag = indexPath.row
            cell._btnReduction.addTarget(self, action: #selector(tapReductionQuantity), for: .touchUpInside)
            cell._btnIncrease.addTarget(self, action: #selector(tapIncreaseQuantity), for: .touchUpInside)
        }
        
        return cell
    }
    @objc func tapReductionQuantity(_ sender: UIButton){
        let index = sender.tag
        let indexPath = NSIndexPath.init(row: index, section: SectionType.product.rawValue)
        let cell = self._tbView.cellForRow(at: indexPath as IndexPath) as! CartProductCell
        
        listDevice[index].reductionQuantity()
        cell._tfQuantity.text = String(listDevice[index].quantity)
        if listDevice[index].quantity == 0{
            let alert = EMAlertController(title: "SEM", message: "Bạn muốn xóa sản phẩm khỏi giỏ hàng không ?")
            let cancel = EMAlertAction(title: "Không", style: .cancel){
                self.listDevice[index].increaseQuantity()
                cell._tfQuantity.text = String(self.listDevice[index].quantity)
                self._tbView.beginUpdates()
                self._tbView.reloadSections(IndexSet(integer: SectionType.price.rawValue), with: .none)
                self._tbView.endUpdates()
            }
            
            let agree = EMAlertAction(title: "Đồng ý", style: .normal){
                self.listDevice.remove(at: index)
                self._tbView.beginUpdates()
                self._tbView.reloadSections(IndexSet(integer: SectionType.product.rawValue), with: UITableViewRowAnimation.none)
                self._tbView.reloadSections(IndexSet(integer: SectionType.price.rawValue), with: .none)
                self._tbView.endUpdates()
                if self.listDevice.count == 0{
                    self.router.gotoBack()
                }
            }
            alert.addAction(cancel)
            alert.addAction(agree)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @objc func tapIncreaseQuantity(_ sender: UIButton){
        let index = sender.tag
        let indexPath = NSIndexPath.init(row: index, section: SectionType.product.rawValue)
        let cell = self._tbView.cellForRow(at: indexPath as IndexPath) as! CartProductCell
        listDevice[index].increaseQuantity()
        cell._tfQuantity.text = String(listDevice[index].quantity)
        _tbView.beginUpdates()
        _tbView.reloadSections(IndexSet(integer: SectionType.price.rawValue), with: .none)
        _tbView.endUpdates()
    }
    
    func configureMethodReceiveCell(at indexPath: IndexPath, in tableView: UITableView) -> MethodReceiveCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MethodReceiveCell") as! MethodReceiveCell
        cell.selectionStyle = .none
        cell._tfAddress.delegate = self
        cell._tfAddress.addTarget(self, action: #selector(self.textFieldSearchChanged), for: .editingChanged)
        cell._tfAddress.tag = 1000
        cell.tag = 1000
        if listShipment.count > 0 {
            cell.reloadData(list: listShipment)
            orderObject.idShipment = listShipment[cell.indexSelected].id!
        }
        cell.delegate = self
        return cell
    }
    
    func didSelectedShipment(object: ShipmentObject){
        orderObject.idShipment = object.id!
    }
    @objc func textFieldSearchChanged(_ textField: UITextField){
        self.interactor.cancelRequest()
        
        interactor.searchPlaces(address: textField.text!,
                                andLat: self.locationManager.location!.coordinate.latitude,
                                andLng: self.locationManager.location!.coordinate.longitude)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)!{
            orderObject.addressReceive = textField.text!
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        interactor.searchPlaces(address: textField.text!,
                                andLat: self.locationManager.location!.coordinate.latitude,
                                andLng: self.locationManager.location!.coordinate.longitude)
        
//        let autoCompleteController = GMSAutocompleteViewController()
//        autoCompleteController.delegate = self
//
//        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    func configureCodePromotionCell(at indexPath: IndexPath, in tableView: UITableView) -> CodePromotionCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodePromotionCell") as! CodePromotionCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func configureInfoPriceCell(at indexPath: IndexPath, in tableView: UITableView) -> InfoPriceCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPriceCell") as! InfoPriceCell
        cell.selectionStyle = .none
        priceAmount = 0
        for i in 0...listDevice.count - 1{
            let dict = listDevice[i]
            priceAmount += dict.salePrice * Double(dict.quantity)
        }
        
        cell._lbAmount.text = priceAmount.currencyString
        
        cell._lbSaleoff.text = priceSaleOff.currencyString
        if promotionObject.id != nil {
            let type = PromotionType(rawValue: promotionObject.type!)!
            switch type{
            case .money:
                priceSaleOff = promotionObject.quantity
                cell._lbSaleoff.text = priceSaleOff.currencyString
            case .percent:
                priceSaleOff = priceAmount * promotionObject.quantity / 100
                cell._lbSaleoff.text = priceSaleOff.currencyString
            default:
                cell._lbSaleoff.text = promotionObject.name
            }
            
        }
        
        cell._lbRest.text = "\((priceAmount - priceSaleOff).currencyString)"
        return cell
    }
    
    func configureButtonOneCell(at indexPath: IndexPath, in tableView: UITableView) -> ButtonOneCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonOneCell") as! ButtonOneCell
        cell.selectionStyle = .none
        
        cell._btnCell.setBackgroundImage(#imageLiteral(resourceName: "buy_button"), for: .normal)
        cell._btnCell.set(backgroundColor: UIColor.clear, titleColor: UIColor.white, title: "TIẾN HÀNH ĐẶT HÀNG", font: UIFont.fontRoboto(style: .Bold, size: 20))
        cell._btnCell.addTarget(self, action: #selector(tapBtnOrder), for: .touchUpInside)
        return cell
    }
    @objc func tapBtnOrder(){
        orderObject.listProduct = listDevice
        orderObject.subTotal = priceAmount
        orderObject.total = priceAmount - priceSaleOff
        if promotionObject.id != nil{
            orderObject.discount = promotionObject.code
        }
        
        if orderObject.addressReceive.isEmpty {
            self.showAlert(withMessage: "Vui lòng nhập địa chỉ nhận hàng")
            return
        }
        router.navigateToOrder(orderInfo: orderObject)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .product:
            return configureCartProductCell(at: indexPath, in: tableView)
        case .method:
            return configureMethodReceiveCell(at: indexPath, in: tableView)
        case .promotion:
            return configureCodePromotionCell(at: indexPath, in: tableView)
        case .price:
            return configureInfoPriceCell(at: indexPath, in: tableView)
        default:
            return configureButtonOneCell(at: indexPath, in: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .product:
            return 100
        case .method:
            return 140
        case .promotion:
            return 60
        case .price:
            return 90
        default:
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == SectionType.product.rawValue{
            if editingStyle == .delete {
                self.listDevice.remove(at: indexPath.row)
                _tbView.deleteRows(at: [indexPath], with: .fade)
                if listDevice.count == 0{
                    router.gotoBack()
                }
            }
        }
        
    }
}
extension CartsViewController: CodePromotionCellDelegate{
    func didPressedBtnConfirm(code: String) {
        self.view.endEditing(true)
        self.interactor.checkCodeDiscount(code: code)
    }
    
    func didEmptyCodeString() {
        self.showAlert(withMessage: "Vui lòng nhập mã giảm giá")
    }
    
    
}
