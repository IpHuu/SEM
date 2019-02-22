//
//  SupportInfoViewController.swift
//  SEM
//
//  Created by Ipman on 1/8/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
private enum TypeInfo: Int{
    case policy,
    support
}
class SupportInfoViewController: BaseViewController {

    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    var typeInfo: Int = TypeInfo.policy.rawValue
    var Items: [ItemTable] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initData()
    }
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 20)
        
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        
        _tbView.registerCellNib(cellClass: AccountsCell.self)
        
    }
    
    func initData(){
        
        if typeInfo == TypeInfo.policy.rawValue {
            _lbHeader.text = "Pháp lý & Chính sách"
            Items.append(ItemTable(title:"Chính sách về quyền riêng tư", image:#imageLiteral(resourceName: "policy_privacy")))
            Items.append(ItemTable(title:"Điều khoản dịch vụ", image:#imageLiteral(resourceName: "setting_report")))
            Items.append(ItemTable(title:"Bản quyền và tác giả", image:#imageLiteral(resourceName: "policy_author")))
        }else{
            _lbHeader.text = "Hỗ trợ"
            Items.append(ItemTable(title:"Hướng dẫn sử dụng", image:#imageLiteral(resourceName: "Support_guide")))
            Items.append(ItemTable(title:"Câu hỏi thường gặp", image:#imageLiteral(resourceName: "support_ask")))
            Items.append(ItemTable(title:"Gửi câu hỏi", image:#imageLiteral(resourceName: "Support_send_question")))
            Items.append(ItemTable(title:"Đóng góp cho ứng dụng", image:#imageLiteral(resourceName: "support_contribute")))
        }
        
        _tbView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SupportInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeInfo == TypeInfo.policy.rawValue {
            return 3
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureKindSupportCell(tableView: tableView,at: indexPath)
    }
    func configureKindSupportCell(tableView: UITableView ,at indexPath: IndexPath) -> AccountsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsCell") as! AccountsCell
        cell.selectionStyle = .none
        let dict = Items[indexPath.row]
        
        cell._lbCell.text = dict.title
        cell._icCell.image = dict.image
        return cell
    }
    
}
