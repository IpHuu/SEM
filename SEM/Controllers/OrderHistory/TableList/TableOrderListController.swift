//
//  TableOrderListController.swift
//  SEM
//
//  Created by Ipman on 1/23/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
protocol TableOrderListControllerDelegate {
    func didSelectedRowTable(order: OrderObject)
}
class TableOrderListController: BaseTableViewController {

    private static let CellIdentifier = "CellIdentifier"
    var interactor: TableOrderListInteractor!
    var router: TableOrderListRouter!
    var delegate: TableOrderListControllerDelegate!
    var status: Int? = nil
    var listOrder = ListOrderObject()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCellNib(cellClass: TableOrderCell.self)
        tableView.registerCellNib(cellClass: OrderSummaryCell.self)
        tableView.estimatedRowHeight = 195
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if status != nil {
            interactor.fetchListHistoryOrder(status: status!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        TableOrderListConfiguator.sharedInstance.configure(viewController: self)
    }
    override init(style: UITableViewStyle) {
        super.init(style: style)
        TableOrderListConfiguator.sharedInstance.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOrder.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureOrderSummaryCell(at: indexPath, in: tableView)
    }
    
    func configureOrderSummaryCell(at indexPath: IndexPath, in tableView: UITableView) -> OrderSummaryCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSummaryCell") as! OrderSummaryCell
        cell.selectionStyle = .none
    
        if listOrder.list.count > 0{
            let dict = listOrder.list[indexPath.row]
            cell._lbCode.text = String(dict.id!)
            cell.updateStatusOrder(status: dict.status!)
            cell._lbQuantity.text = "\(dict.totalQuantity) sản phẩm"
            cell._lbTotalPrice.text = dict.subTotal.currencyString
            
            cell._lbAddress.text = dict.addressReceive
            cell._lbTime.text = convertToShowFormatDate(dateString: dict.createdAt)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = listOrder.list[indexPath.row]
        delegate.didSelectedRowTable(order: dict)
    }
}
extension TableOrderListController: TableOrderListPresenterOutput{
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
    func presentListHistoryOrder(listOrder: ListOrderObject){
        self.listOrder = listOrder
        tableView.reloadData()
    }
}
