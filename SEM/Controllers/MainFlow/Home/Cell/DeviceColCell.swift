//
//  DeviceColCell.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
protocol DeviceColCellDelegate {
    func didChangeSwitchPressed(indexPath: IndexPath, isOn: Bool)
}
class DeviceColCell: UICollectionViewCell {

    @IBOutlet weak var _imgProduct: UIImageView!
    
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbStatus: UILabel!
    @IBOutlet weak var _viewbg: UIView!
    @IBOutlet weak var _viewStack: UIStackView!
    
    @IBOutlet weak var _viewSwitch: UIView!
    var btnSwitch: CustomSwitch!
    var delegate: DeviceColCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSwitch = CustomSwitch(frame: CGRect(x:10, y: 10, width: 40, height: 15))
        btnSwitch.isOn = false
        btnSwitch.onTintColor = UIColor.greenMainColor
        btnSwitch.offTintColor = UIColor.darkGray
        btnSwitch._cornerRadius = 0.1
        btnSwitch.thumbCornerRadius = 0.1
        btnSwitch.thumbSize = CGSize(width: 20, height: 20)
        btnSwitch.thumbTintColor = UIColor.white
        btnSwitch.addTarget(self, action: #selector(changeSwitchPressed), for: .touchUpInside)
        _viewSwitch.addSubview(btnSwitch)
        // Initialization code`
    }
    @objc func changeSwitchPressed(){
        
        let collectionView = self.superview as! UICollectionView
        let tappedCellIndexPath = collectionView.indexPath(for: self)!

        delegate.didChangeSwitchPressed(indexPath: tappedCellIndexPath, isOn: self.btnSwitch.isOn)
    }
}
