//
//  PlacesSearchViewController.swift
//  SEM
//
//  Created by Ipman on 1/10/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
protocol PlacesSearchViewControllerDelegate {
    func didSelectedSearchPlace(place: GGPredictionObject)
}
class PlacesSearchViewController: BaseTableViewController {

    var listPlace =  [GGPredictionObject]()
    var delegate: PlacesSearchViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(listPlace: [GGPredictionObject]){
        self.listPlace = listPlace
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listPlace.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.font = UIFont.fontRoboto(style: .Regular, size: 14)
        cell.textLabel?.textColor = UIColor.grayMainTextColor
        cell.textLabel?.text = listPlace[indexPath.row].description

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectedSearchPlace(place: listPlace[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
