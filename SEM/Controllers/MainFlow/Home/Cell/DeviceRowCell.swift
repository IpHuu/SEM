//
//  DeviceRowCell.swift
//  SEM
//
//  Created by Ipman on 12/21/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class DeviceRowCell: UITableViewCell {

    @IBOutlet weak var _colView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _colView.delegate = self
        _colView.dataSource = self
        self._colView.registerCellNib(cellClass: DeviceColCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension DeviceRowCell:UICollectionViewDataSource , UICollectionViewDelegate, DeviceColCellDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceColCell", for: indexPath) as! DeviceColCell
        
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        
        cell.delegate = self
        
        return cell
    }
    
    func didChangeSwitchPressed(indexPath: IndexPath, isOn: Bool){
        print("indexPath: \(indexPath.row) isOn: \(isOn)")
    }
}
extension DeviceRowCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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
