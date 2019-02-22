//
//  LocationCameraCell.swift
//  SEM
//
//  Created by Ipman on 12/21/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class LocationCameraCell: UICollectionViewCell {

    @IBOutlet weak var _viewBg: UIView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbStatus: UILabel!
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                _viewBg.backgroundColor = UIColor.yellowMainColor
                _lbName.textColor = UIColor.white
                _lbStatus.textColor = UIColor.white
            }else{
                _viewBg.backgroundColor = UIColor.white
                _lbName.textColor = UIColor.blackMainTitleColor
                _lbStatus.textColor = UIColor.grayMainColor
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 15)
        _lbStatus.font = UIFont.fontRoboto(style: .Light, size: 12)
    }

}
