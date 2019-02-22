//
//  ProductsViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
private enum SectionTBProduct: Int{
    case banner,
    category,
    promotion
}
class ProductsViewController: BaseViewController {
    
    var interactor: ProductsInteractor!
    var router: ProductsRouter!
    @IBOutlet weak var _tfSearch: UITextField!
    @IBOutlet weak var _iconSearch: UIImageView!
    @IBOutlet weak var _icCart: UIImageView!
    @IBOutlet weak var _lbCartQty: UILabel!
    
    @IBOutlet weak var _tbView: UITableView!
    var imagesArray = [Any]()
    var slider : SBSliderView?
    var listCategory = [GroupDeviceObject]()
    var counterItem = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductsConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    func initUI(){
        _tfSearch.placeholder = "Sản phẩm, thương hiệu..."
        _tfSearch.backgroundColor = UIColor.grayLightBackgroundColor
        _tfSearch.setLeftPaddingPoints(45)
        _tfSearch.isEnabled = false
        
        _lbCartQty.layer.cornerRadius = _lbCartQty.frame.size.height/2
        _lbCartQty.font = UIFont.fontRoboto(style: .Regular, size: 12)
        _lbCartQty.textColor = UIColor.white
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.registerCellNib(cellClass: ProductsCell.self)
        _tbView.registerCellNib(cellClass: CategoryCell.self)
        _tbView.registerCellNib(cellClass: BannerCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
        _tbView.separatorStyle = .none
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageCartTapped(tapGestureRecognizer:)))
        _icCart.isUserInteractionEnabled = true
        _icCart.addGestureRecognizer(tapGestureRecognizer)
        
        imagesArray.append(#imageLiteral(resourceName: "Banner2"))
        imagesArray.append(#imageLiteral(resourceName: "background_header"))
    }
    func loadData(){
        _lbCartQty.text = "\(AuthenticationManager.sharedInstance.cachedCartDevice.count)"
        interactor.getListGroupDevice()
    }
    @objc func imageCartTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if AuthenticationManager.sharedInstance.cachedCartDevice.count == 0 {
            MyFunctions.shakingView(tempView: _icCart)
            return
        }else{
            router.navigateToCart()
        }
        
    }
    
    
    
}
extension ProductsViewController: ProductsPresenterOutput{
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
    func presentListGroupDevice(data: [GroupDeviceObject]){
        if data.count > 0 {
            self.listCategory = data
            _tbView.reloadData()
        }
    }
}
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource, CategoryCellDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        let sectionType = SectionTBProduct(rawValue: section)!
        switch sectionType {
        case .category:
            header._lbTilte.text = "Dòng sản phẩm"
            return header
        case .promotion:
            header._lbTilte.text = "Sản phẩm khuyến mãi"
            return header
        case .banner:
            return nil
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionTBProduct(rawValue: section)!
        
        switch sectionType {
        case .category:
            return 40
        case .promotion:
            return 40
        default:
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionTBProduct(rawValue: section)!
        
        switch sectionType {
        case .category:
            return 10
        case .banner:
            return 10
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section =  SectionTBProduct(rawValue: section)!
        switch section {
        case .promotion:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section =  SectionTBProduct(rawValue: indexPath.section)!
        switch section {
        case .promotion:
            return configureProductsCell(at: indexPath, in: tableView)
        case .banner:
            return configureBannerCell(tableView:tableView, indexPath:indexPath)
        default:
            return configureCategoryCell(at: indexPath, in: tableView)
        }
    }
    
    func configureBannerCell(tableView: UITableView, indexPath: IndexPath) -> BannerCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as! BannerCell
        slider = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        slider?.delegate = self
        
        slider?.createSlider(withImages: imagesArray, withAutoScroll: true, in: cell._viewSlider)
        slider?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(cell._viewSlider.frame.size.width), height: CGFloat(cell._viewSlider.frame.size.height))
        cell._viewSlider.addSubview(slider!)
        return cell
    }
    
    func configureProductsCell(at indexPath: IndexPath, in tableView: UITableView) -> ProductsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell") as! ProductsCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func configureCategoryCell(at indexPath: IndexPath, in tableView: UITableView) -> CategoryCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.selectionStyle = .none
        cell.initData(data: listCategory)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section =  SectionTBProduct(rawValue: indexPath.section)!
        switch section {
        case .promotion:
            return 130
        case .banner:
            return 150
        default:
            let itemsPerRow:CGFloat = 3.5// số phần tử hiện thị
            let hardCodedPadding:CGFloat = 10 // padding giữa các cell
            let itemWidth = (_tbView.bounds.width / itemsPerRow) - hardCodedPadding
            return itemWidth + 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section =  SectionTBProduct(rawValue: indexPath.section)!
        switch section {
        case .promotion:
            router.navigateToProductDetails()
//            self.addToCart(indexPath: indexPath)
        default:
            break
        }
    }
    
    func addToCart(indexPath: IndexPath){
        let cell = self._tbView.cellForRow(at: indexPath) as! ProductsCell
        let imageViewPosition : CGPoint = cell._imgProduct.convert(cell._imgProduct.bounds.origin, to: self.view)
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell._imgProduct.frame.size.width, height: cell._imgProduct.frame.size.height))
        
        imgViewTemp.image = cell._imgProduct.image
        imgViewTemp.contentMode = .scaleAspectFit
        MyFunctions.animationFlyToCart(addSubview: self.view, tempView: imgViewTemp, to: _icCart){
            self.counterItem += 1
            self._lbCartQty.text = "\(self.counterItem)"
        }
        
    }
    func didSelectCategoryCell(group: GroupDeviceObject){
        router.navigateToLisDeviceByGroupID(groupID: group)
    }
}
extension ProductsViewController: SBSliderDelegate{
    func sbslider(_ sbslider: SBSliderView, didTapOn targetImage: UIImage, andParentView targetView: UIImageView , andWithTag tag: Int) {
        //        print("\(tag)")
        //
        //        guard let url = URL(string: banner[tag].link) else {
        //            return //be safe
        //        }
        //
        //        if #available(iOS 10.0, *) {
        //            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //        } else {
        //            UIApplication.shared.openURL(url)
        //        }
    }
}
