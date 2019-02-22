//
//  MethodColCell.swift
//  SEM
//
//  Created by Ipman on 1/14/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class MethodColCell: UICollectionViewCell {

    @IBOutlet weak var _viewBg: UIView!
    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _lbTime: UILabel!
    @IBOutlet weak var _lbPrice: UILabel!
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                _viewBg.backgroundColor = UIColor.MethodReceive.activeBackgroundColor
                _lbTitle.textColor = UIColor.white
                _lbTime.textColor = UIColor.white
                _lbPrice.textColor = UIColor.white
            }else{
                _viewBg.backgroundColor = UIColor.MethodReceive.normalBackgroundColor
                _lbTitle.textColor = UIColor.MethodReceive.titleColor
                _lbTime.textColor = UIColor.MethodReceive.detailColor
                _lbPrice.textColor = UIColor.MethodReceive.detailColor
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbTime.font = UIFont.fontRoboto(style: .Regular, size: 12)
        _lbPrice.font = UIFont.fontRoboto(style: .Regular, size: 12)

        _viewBg.backgroundColor = UIColor.MethodReceive.normalBackgroundColor
        _lbTitle.textColor = UIColor.MethodReceive.titleColor
        _lbTime.textColor = UIColor.MethodReceive.detailColor
        _lbPrice.textColor = UIColor.MethodReceive.detailColor
    }

}
