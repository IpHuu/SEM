//
//  CameraMonitoringCell.swift
//  SEM
//
//  Created by Ipman on 12/21/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class CameraMonitoringCell: UITableViewCell {

    @IBOutlet weak var _viewScreen: UIView!
    @IBOutlet weak var _colView: UICollectionView!
    var categories = ["Phòng khách", "Phòng ngủ", "Hành lang", "Nhà bếp", "Sân thượng"]
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    var indexSelected: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _colView.delegate = self
        _colView.dataSource = self
        self._colView.registerCellNib(cellClass: LocationCameraCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CameraMonitoringCell:UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCameraCell", for: indexPath) as! LocationCameraCell
        
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        
        cell._lbName.text = categories[indexPath.row]
        cell._lbStatus.text = "An toàn"
        
        cell.isSelected = indexSelected == indexPath.row ? true : false
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexSelected = indexPath.row
        _colView.reloadData()
//        let cell = self._colView.cellForItem(at: indexPath) as! LocationCameraCell
//        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = self._colView.cellForItem(at: indexPath) as! LocationCameraCell
//        cell.isSelected = false
    }
}
extension CameraMonitoringCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = categories[indexPath.row].width(withFont: UIFont.fontRoboto(style: .Bold, size: 15))
        return CGSize(width: widthPerItem + 20, height: 60)
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
