//
//  ListSelectionCell.swift
//  SEM
//
//  Created by Ipman on 1/22/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class ListSelectionCell: UITableViewCell {

    @IBOutlet weak var _colView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var listString = [String]()
    var indexSelected: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _colView.delegate = self
        _colView.dataSource = self
        _colView.registerCellNib(cellClass: SelectionCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(list: [String]){
        listString = list
        _colView.reloadData()
    }
    
}
extension ListSelectionCell: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        
        cell._lbTitle.text = listString[indexPath.row]
        cell.isSelected = indexSelected == indexPath.row
        return cell
    }
}
extension ListSelectionCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.bounds.width / 2 - 20
        return CGSize(width: widthPerItem, height: 50)
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
