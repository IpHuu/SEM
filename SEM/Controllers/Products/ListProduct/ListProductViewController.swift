//
//  ListProductViewController.swift
//  SEM
//
//  Created by Ipman on 1/7/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
class ListProductViewController: BaseViewController {

    var interactor: ListProductInteractor!
    var router: ListProductRouter!
    
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    @IBOutlet weak var _lbNoneProduct: UILabel!
    
    var groupID = GroupDeviceObject()
    var listDevice = [DeviceObject]()
    var currPage: Int = 1
    var lpp: Int = 10
    var totalPage: Int = 0
    @IBOutlet weak var _icCart: UIImageView!
    @IBOutlet weak var _lbQty: UILabel!
    var currentRequest: Request?
    override func awakeFromNib() {
        super.awakeFromNib()
        ListProductConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        
    }
    func initUI(){
        _lbQty.cornerRadius = _lbQty.frame.size.height / 2
        _lbQty.font = UIFont.fontRoboto(style: .Regular, size: 12)
        _lbQty.textColor = UIColor.white
        
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _tbView.registerCellNib(cellClass: ProductsCell.self)
        _tbView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        _tbView.separatorStyle = .none
        _tbView.delegate = self
        _tbView.dataSource = self
        
        _lbNoneProduct.font = UIFont.fontRoboto(style: .Regular, size: 18)
        _lbNoneProduct.text =  "Không có sản phẩm nào"
        _lbNoneProduct.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageCartTapped(tapGestureRecognizer:)))
        _icCart.isUserInteractionEnabled = true
        _icCart.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageCartTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if AuthenticationManager.sharedInstance.cachedCartDevice.count == 0 {
            MyFunctions.shakingView(tempView: _icCart)
            return
        }else{
            router.navigateToCart()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _lbHeader.text = groupID.name
        interactor.fetchListDevice(groupID: groupID.id!, page: currPage, lpp: lpp)
        _lbQty.text = "\(AuthenticationManager.sharedInstance.cachedCartDevice.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
}
extension ListProductViewController: ListProductPresenterOutput{
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
    func presentFetchListDeviceSuccess(listObject: [DeviceObject], paging: PagingObject){
        if listObject.count == 0 {
            _lbNoneProduct.isHidden = false
            return
        }
        self.listDevice.append(contentsOf: listObject)
        self.totalPage = paging.num_pages
        _tbView.reloadData()
    }
}
extension ListProductViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDevice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureProductsCell(at: indexPath, in: tableView)
    }
    
    func configureProductsCell(at indexPath: IndexPath, in tableView: UITableView) -> ProductsCell{
        let cell = tableView.dequeueReusableCell(cellClass: ProductsCell.self) as! ProductsCell
        cell.selectionStyle = .none
        
        let dict = listDevice[indexPath.row]
        cell._imgProduct.sd_setImage(with: URL(string: APIConstants.baseURLImage + dict.img), placeholderImage: #imageLiteral(resourceName: "logo_png"))
        cell._lbName.text = dict.name
        cell._lbPrice.text = dict.salePrice.currencyString
        cell._lbDescription.text = dict.description
        cell._lbBasePrice.attributedText = dict.basePrice.currencyString.strikeThrough()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listDevice.count - 1{
            if currPage == totalPage {
                print("Load hết sản phẩm")
                return
                
            }
            currPage += 1
            self.interactor.fetchListDevice(groupID: groupID.id!, page: currPage, lpp: lpp)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = listDevice[indexPath.row]
        router.navigateToDetailDevice(deviceId: dict.id!)
    }
}
