//
//  CategoryDevicesColCell.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class CategoryDevicesColCell: UICollectionViewCell {

    @IBOutlet weak var _viewBg: UIView!
    @IBOutlet weak var _imgIcon: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        _viewBg.makeShadowRound()
        
        _lbName.font = UIFont.fontRoboto(style: .Regular, size: 14)
    }

}
