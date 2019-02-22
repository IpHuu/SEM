//
//  ProductDetailsViewController.swift
//  SEM
//
//  Created by Ipman on 12/25/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

private enum SectionDetails: Int{
    case image,
    infoSummary,
    infoDetails,
    moreProduct
}
private enum TabType: Int{
    case intro,
    info,
    evaluate
}
class ProductDetailsViewController: BaseViewController, CAAnimationDelegate {

    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _icBack: UIButton!
    @IBOutlet weak var _icCart: UIButton!
    @IBOutlet weak var _lbQty: UILabel!
    
    @IBOutlet weak var _tbView: UITableView!
    @IBOutlet weak var _viewFooter: UIView!
    @IBOutlet weak var _btnAdd: UIButton!
    @IBOutlet weak var _lbAdd: UILabel!
    @IBOutlet weak var _icAdd: UIImageView!
    
    
    var selectedTab: Int = 0
    var imagesArray = [Any]()
    var slider : SBSliderView?
    var interactor: ProductDetailsInteractor!
    var router: ProductDetailsRouter!
    var deviceID: Int? = nil
    var deviceInfo = DeviceObject()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        imagesArray.append(#imageLiteral(resourceName: "logo_png"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if deviceID != nil{
            interactor.getDetailDevice(deviceID: deviceID!)
        }
        updateQuantityCart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductDetailsConfiguator.sharedInstance.configure(viewController: self)
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Sản phẩm"
        _lbQty.cornerRadius = _lbQty.frame.size.height / 2
        _lbQty.font = UIFont.fontRoboto(style: .Regular, size: 12)
        _lbQty.textColor = UIColor.white
        
        _lbAdd.font = UIFont.fontRoboto(style: .Bold, size: 18)
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.registerCellNib(cellClass: ProductSummaryCell.self)
        _tbView.registerCellNib(cellClass: BannerCell.self)
        _tbView.registerCellNib(cellClass: ProductsCell.self)
        _tbView.registerCellNib(cellClass: CommentEvaluateCell.self)
        _tbView.registerCellNib(cellClass: EvaluateCell.self)
        _tbView.registerCellNib(cellClass: InfoTechnicalCell.self)
        _tbView.registerCellNib(cellClass: IntroductionTextCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
        _tbView.register(UINib.init(nibName: "ViewTabHeaderSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "ViewTabHeaderSection")
    }
    @IBAction func icBackPressed(_ sender: Any) {
        router.gotoBack()
    }
    
    @IBAction func icCartPressed(_ sender: Any) {
        if AuthenticationManager.sharedInstance.cachedCartDevice.count > 0{
            router.navigateToCart()
        }else{
            self.showAlert(withMessage: "Vui lòng thêm sản phẩm vào giỏ hàng")
        }
    }
    
    
    @IBAction func btnAddPressed(_ sender: Any) {
        
        MyFunctions.flyProductDetailToCart(viewcontroller: self, from: slider!, to: _icCart)
        
        let isExsist = MyFunctions.checkExsistDeviceInCart(device: self.deviceInfo)
        if !isExsist {
           AuthenticationManager.sharedInstance.cachedCartDevice.append(self.deviceInfo)
        }
        updateQuantityCart()
    }
    func updateQuantityCart(){
        _lbQty.text = String(AuthenticationManager.sharedInstance.cachedCartDevice.count)
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag && ((anim.value(forKey: "animationName") as? String) == "curvedAnim") {
            //self._icCart.setBackgroundImage(#imageLiteral(resourceName: "logo_png"), for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self._icCart.animationZoom(scaleX: 1.3, y: 1.3)
            }, completion: {_ in
                self._icCart.animationZoom(scaleX: 1.0, y: 1.0)
            })
        }
    }
}
extension ProductDetailsViewController: ProductDetailsPresenterOutput{
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
    func presentDetailDevice(device: DeviceObject){
        self.deviceInfo = device
        if deviceInfo.id != nil && !deviceInfo.img.isEmpty {
            imagesArray.removeAll()
            DispatchQueue.global().async {
                if let data = NSData(contentsOf: URL(string: APIConstants.baseURLImage + self.deviceInfo.img)!) {
                    let image = UIImage(data: data as Data)!
                    self.imagesArray.append(image)
                }else{
                    self.imagesArray.append(#imageLiteral(resourceName: "logo_png"))
                }
                DispatchQueue.main.async {
                    self._tbView.reloadData()
                }
            }
            return
        }
        self._tbView.reloadData()
        
    }
}

extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionType = SectionDetails(rawValue: section)!
        
        switch sectionType {
        case .moreProduct:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
            header._lbTilte.text = "Sản phẩm liên quan"
            return header
        case .infoDetails:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ViewTabHeaderSection") as! ViewTabHeaderSection
            header._btnInfo.addTarget(self, action: #selector(didTapHeaderSection(_:)), for: .touchUpInside)
            header._btnEvaluate.addTarget(self, action: #selector(didTapHeaderSection(_:)), for: .touchUpInside)
            header._btnIntroduction.addTarget(self, action: #selector(didTapHeaderSection(_:)), for: .touchUpInside)
            header.activeTab(tag: selectedTab)
            return header
        default:
            return nil
        }
        
        
    }
    @objc func didTapHeaderSection(_ sender: UIButton){
        selectedTab = sender.tag
        _tbView.beginUpdates()
        _tbView.reloadSections(IndexSet(integer: SectionDetails.infoDetails.rawValue), with: .none)
        _tbView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionDetails(rawValue: section)!
        
        switch sectionType {
        case .moreProduct:
            return 40
        case .infoDetails:
            return 40
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionDetails(rawValue: section)!
        
        switch sectionType {
        case .infoDetails:
            return 10
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section =  SectionDetails(rawValue: section)!
        switch section {
        case .moreProduct:
            return 5
        case .infoDetails:
            if selectedTab == TabType.info.rawValue{
                return 5
            }else if selectedTab == TabType.intro.rawValue{
                return 1
            }else{
                return 1 + 2
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section =  SectionDetails(rawValue: indexPath.section)!
        switch section {
        case .image:
            return configureBannerCell(tableView:tableView, indexPath:indexPath)
        case .infoDetails:
            if selectedTab == TabType.info.rawValue{
                return configureInfoTechnicalCell(at: indexPath, in: tableView)
            }else if selectedTab == TabType.intro.rawValue{
                return configureIntroductionTextCell(at: indexPath, in: tableView)
            }else{
                if indexPath.row == 0{
                    return configureEvaluateCell(at: indexPath, in: tableView)
                }
                return configureCommentEvaluateCell(at: indexPath, in: tableView)
            }
        case .infoSummary:
            return configureProductSummaryCell(tableView:tableView, indexPath:indexPath)
        default:
            return configureProductsCell(at: indexPath, in: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionDetails(rawValue: indexPath.section)!
        
        switch sectionType {
        case .image:
            return 300
        case .infoDetails:
            if selectedTab == TabType.info.rawValue{
                return 60
            }else if selectedTab == TabType.intro.rawValue{
                return 200
            }else{
                if indexPath.row == 0{
                    return 80
                }
                return 150
            }
        case .moreProduct:
            return 130
        default:
            return 150
        }
        
    }
    func configureIntroductionTextCell(at indexPath: IndexPath, in tableView: UITableView) -> IntroductionTextCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntroductionTextCell") as! IntroductionTextCell
        cell.selectionStyle = .none
        
        return cell
    }
    func configureInfoTechnicalCell(at indexPath: IndexPath, in tableView: UITableView) -> InfoTechnicalCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTechnicalCell") as! InfoTechnicalCell
        cell.selectionStyle = .none
        
        return cell
    }
    func configureCommentEvaluateCell(at indexPath: IndexPath, in tableView: UITableView) -> CommentEvaluateCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentEvaluateCell") as! CommentEvaluateCell
        cell.selectionStyle = .none
        
        return cell
    }
    func configureEvaluateCell(at indexPath: IndexPath, in tableView: UITableView) -> EvaluateCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "EvaluateCell") as! EvaluateCell
        cell.selectionStyle = .none
        
        return cell
    }
    func configureProductsCell(at indexPath: IndexPath, in tableView: UITableView) -> ProductsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell") as! ProductsCell
        cell.selectionStyle = .none
        
        return cell
    }
    func configureProductSummaryCell(tableView: UITableView, indexPath: IndexPath) -> ProductSummaryCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSummaryCell") as! ProductSummaryCell
        cell.selectionStyle = .none
        
        if deviceInfo.id != nil {
            cell._lbName.text = deviceInfo.name
            cell._lbPrice.text = deviceInfo.salePrice.currencyString
        }
        
        cell._lbPointRating.text = "\(cell._viewRating.value) (200 đánh giá)"
        
        
        return cell
    }
    func configureBannerCell(tableView: UITableView, indexPath: IndexPath) -> BannerCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as! BannerCell
        slider = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        slider?.delegate = self

        self.slider?.createSlider(withImages: self.imagesArray, withAutoScroll: true, in: cell._viewSlider)
        self.slider?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(cell._viewSlider.frame.size.width), height: CGFloat(cell._viewSlider.frame.size.height))
        slider?.pageIndicator.isHidden = true
        cell._viewSlider.addSubview(self.slider!)
        return cell
    }
    
}
extension ProductDetailsViewController: SBSliderDelegate{
    func sbslider(_ sbslider: SBSliderView, didTapOn targetImage: UIImage, andParentView targetView: UIImageView , andWithTag tag: Int) {
    }
}
