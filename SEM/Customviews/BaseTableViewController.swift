//
//  BaseTableViewController.swift
//  SEM
//
//  Created by Ip Man on 11/14/18.
//  Copyright © 2018 Ip Man. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var indicatorView: IndicatorView?
    
    override init(style: UITableViewStyle = .grouped) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
//        self.setNavigationbarStyle()
//        self.setBackButtonOnNavigationBar()
        
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
    // MARK: Loading HUD
    // showloading
    func showLoading(withMessage message: String?=nil){
        if indicatorView == nil{
            indicatorView = IndicatorView()
            indicatorView!.message = message
        }
        indicatorView!.show()
    }
    
    // hide loading
    func hideLoading() {
        if let indicatorView = indicatorView{
            indicatorView.dismiss()
            self.indicatorView = nil
        }
    }
    
}
