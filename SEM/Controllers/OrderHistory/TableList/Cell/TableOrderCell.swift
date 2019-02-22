//
//  TableOrderCell.swift
//  SEM
//
//  Created by Ipman on 1/23/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class TableOrderCell: UITableViewCell {

    @IBOutlet weak var _imgProduct: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbDescription: UILabel!
    @IBOutlet weak var _lbQuantity: UILabel!
    @IBOutlet weak var _lbPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbDescription.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbDescription.textColor = UIColor.grayLightTextColor
        _lbQuantity.font = UIFont.fontRoboto(style: .Bold, size: 16)
        
        _lbPrice.font = UIFont.fontRoboto(style: .Light, size: 16)
        _lbPrice.textColor = UIColor.redMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
