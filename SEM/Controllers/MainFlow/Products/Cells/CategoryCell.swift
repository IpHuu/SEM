//
//  CategoryCell.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import SDWebImage
protocol CategoryCellDelegate {
    func didSelectCategoryCell(group: GroupDeviceObject)
}

class CategoryCell: UITableViewCell {
    @IBOutlet weak var _colView: UICollectionView!
    var Items: [ItemTable] = []
    var listCategory = [GroupDeviceObject]()
    var delegate: CategoryCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _colView.delegate = self
        _colView.dataSource = self
        self._colView.registerCellNib(cellClass: CategoryDevicesColCell.self)
        Items.append(ItemTable(title:"Security", image:#imageLiteral(resourceName: "product_security")))
        Items.append(ItemTable(title:"Cleaner", image:#imageLiteral(resourceName: "Product_cleaner_icon")))
        Items.append(ItemTable(title:"Camera", image:#imageLiteral(resourceName: "product_camera")))
        Items.append(ItemTable(title:"Light", image:#imageLiteral(resourceName: "Product_light")))
        Items.append(ItemTable(title:"Air-conding", image:#imageLiteral(resourceName: "product_condition")))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initData(data: [GroupDeviceObject]){
        listCategory = data
        self._colView.reloadData()
    }
    
}
extension CategoryCell:UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDevicesColCell", for: indexPath) as! CategoryDevicesColCell
        
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;

        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        
        let dict = listCategory[indexPath.row]
        cell._imgIcon.sd_setImage(with: URL(string: APIConstants.baseURLImage + dict.img), placeholderImage: #imageLiteral(resourceName: "logo_png"))
        cell._lbName.text = dict.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = listCategory[indexPath.row]
        delegate.didSelectCategoryCell(group: dict)
    }
}
extension CategoryCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3.5// số phần tử hiện thị
        let hardCodedPadding:CGFloat = 10 // padding giữa các cell
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    }
}
