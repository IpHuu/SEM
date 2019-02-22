//
//  ProductsCell.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class ProductsCell: UITableViewCell {

    @IBOutlet weak var _viewBottom: UIView!
    
    @IBOutlet weak var _lbPrice: UILabel!
    @IBOutlet weak var _imgProduct: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbDescription: UILabel!
    @IBOutlet weak var _imgSaleOff: UIImageView!
    @IBOutlet weak var _lbBasePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _lbDescription.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbDescription.textColor = UIColor.blueTextColor
        _lbPrice.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbBasePrice.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbBasePrice.textColor = UIColor.grayLightTextColor
        _lbBasePrice.attributedText = "1.000.000đ".strikeThrough()
        _imgSaleOff.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
