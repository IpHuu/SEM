//
//  ServicesOrderViewController.swift
//  SEM
//
//  Created by Ipman on 1/21/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
private enum SectionType: Int{
    case time,
    address,
    purpose,
    note,
    button
}
class ServicesOrderViewController: BaseViewController {

    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    var isSelectedTime: Int = 0
    var isSelectedPurpose: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI(){
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.registerCellNib(cellClass: ButtonOneCell.self)
        _tbView.registerCellNib(cellClass: ListSelectionCell.self)
        _tbView.registerCellNib(cellClass: TextFieldCell.self)
        _tbView.registerCellNib(cellClass: TextViewCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
    }
    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ServicesOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        header._lbMore.isHidden = true
        let sectionType = SectionType(rawValue: section)!
        
        switch sectionType {
        case .time:
            header._lbTilte.text = "1. Thời gian cần bảo vệ"
        case .address:
            header._lbTilte.text = "2. Địa điểm bảo vệ sẽ đến"
        case .purpose:
            header._lbTilte.text = "3. Bạn cần nhân viên bảo vệ để"
        case .note:
            header._lbTilte.text = "4. Ghi chú"
        default:
            return nil
        }
        return header
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
        return 0.1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SectionType(rawValue: section)!
        switch section {
        case .purpose:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SectionType(rawValue: indexPath.section)!
        switch section {
        case .time:
            return configureListSelectionCell(at: indexPath, in: tableView)
        case .purpose:
            if indexPath.row == 0{
                return configureListSelectionCell(at: indexPath, in: tableView)
            }
            return configureTextFieldCell(at: indexPath, in: tableView)
        case .note:
            return configureTextViewCell(at: indexPath, in: tableView)
        case .address:
            return configureTextFieldCell(at: indexPath, in: tableView)
        default:
            return configureButtonCell(at: indexPath, in: tableView)
        }
    }
    
    func configureButtonCell(at indexPath: IndexPath, in tableView: UITableView) -> ButtonOneCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonOneCell") as! ButtonOneCell
        cell.selectionStyle = .none
        cell._btnCell.setBackgroundImage(#imageLiteral(resourceName: "buy_button"), for: .normal)
        cell._btnCell.set(backgroundColor: UIColor.clear, titleColor: UIColor.white, title: "ĐẶT NGAY", font: UIFont.fontRoboto(style: .Bold, size: 20))
        return cell
    }
    
    func configureListSelectionCell(at indexPath: IndexPath, in tableView: UITableView) -> ListSelectionCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListSelectionCell") as! ListSelectionCell
        cell.selectionStyle = .none
        
        if indexPath.section == SectionType.time.rawValue{
            cell.indexSelected = isSelectedTime
            cell.reloadData(list: ["Đặt ngay bây giờ","Đặt lúc khác"])
            
        }
        
        if indexPath.section == SectionType.purpose.rawValue && indexPath.row == 0 {
            cell.indexSelected = isSelectedPurpose
            cell.reloadData(list: ["Bảo vệ nơi bạn ở","Theo bạn ra ngoài","Theo bảo vệ ai đó","Bảo vệ một món hàng"])
            
        }
        
        
        return cell
    }
    func configureTextViewCell(at indexPath: IndexPath, in tableView: UITableView) -> TextViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell") as! TextViewCell
        cell.selectionStyle = .none
        cell._tvInput.placeholder = "Ghi chú"
        return cell
    }
    func configureTextFieldCell(at indexPath: IndexPath, in tableView: UITableView) -> TextFieldCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
        cell.selectionStyle = .none
        
        if indexPath.section == SectionType.address.rawValue{
            cell._tfInput.placeholder = "Địa điểm đến..."
        }
        
        if indexPath.section == SectionType.purpose.rawValue && indexPath.row == 1{
            cell._tfInput.placeholder = "Mục đích khác..."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = SectionType(rawValue: indexPath.section)!
        switch section {
        case .time:
            return 70
        case .purpose:
            if indexPath.row == 0{
                return 140
            }
            return 60
        case .note:
            return 100
        case .button:
            return 70
        default:
            return 60
        }
    }


}

