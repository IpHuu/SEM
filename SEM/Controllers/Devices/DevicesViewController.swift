//
//  DevicesViewController.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class DevicesViewController: BaseViewController {

    @IBOutlet weak var _icBack: UIButton!
    @IBOutlet weak var _icMore: UIButton!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tbView: UITableView!
    
    var interactor: DevicesInteractor!
    var router: DevicesRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbHeader.text = "Thiết bị"
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.registerCellNib(cellClass: DeviceCell.self)
        _tbView.register(UINib.init(nibName: "HeaderTableViewProducts", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewProducts")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        DevicesConfiguator.sharedInstance.configure(viewController: self)
    }
    @IBAction func tapIcBack(_ sender: Any) {
        router.gotoBack()
    }
    @IBAction func tapIcMore(_ sender: Any) {
        
    }
}
extension DevicesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewProducts") as! HeaderTableViewProducts
        header._lbTilte.text = "Thiết bị: 8"
        header._lbMore.isHidden = true
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
extension DevicesViewController: DevicesPresenterOutput{
    
}
