//
//  MethodReceiveCell.swift
//  SEM
//
//  Created by Ipman on 1/4/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

protocol MethodReceiveCellDelegate {
    func didSelectedShipment(object: ShipmentObject)
}
private enum MethodReceive: Int{
    case normal,
    flash
}
class MethodReceiveCell: UITableViewCell {

    @IBOutlet weak var _tfAddress: UITextField!
    @IBOutlet weak var _colView: UICollectionView!
    var listMethod = [ShipmentObject]()
    var delegate: MethodReceiveCellDelegate!
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 5.0)
    var indexSelected: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _tfAddress.placeholder = "Vị trí giao hàng"
        _colView.delegate = self
        _colView.dataSource = self
        self._colView.registerCellNib(cellClass: MethodColCell.self)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(list: [ShipmentObject]){
        listMethod = list
        _colView.reloadData()
    }
    
}
extension MethodReceiveCell:UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMethod.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MethodColCell", for: indexPath) as! MethodColCell
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        
        if listMethod.count > 0{
            cell._lbTitle.text = listMethod[indexPath.row].name
            cell._lbTime.text = listMethod[indexPath.row].unit
            cell._lbPrice.text = listMethod[indexPath.row].price.currencyString
            cell.isSelected = indexSelected == indexPath.row ? true : false
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        _colView.reloadData()
        delegate.didSelectedShipment(object: listMethod[indexSelected])
    }
    
}
extension MethodReceiveCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.bounds.width / 2 - 10
        return CGSize(width: widthPerItem, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
