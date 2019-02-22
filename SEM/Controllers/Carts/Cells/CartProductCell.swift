//
//  CartProductCell.swift
//  SEM
//
//  Created by Ipman on 1/4/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class CartProductCell: UITableViewCell {

    @IBOutlet weak var _imgProduct: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbDescription: UILabel!
    @IBOutlet weak var _lbPrice: UILabel!
    @IBOutlet weak var _tfQuantity: UITextField!
    
    @IBOutlet weak var _btnReduction: UIButton!
    
    @IBOutlet weak var _btnIncrease: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbPrice.font = UIFont.fontRoboto(style: .Bold, size: 17)
        _lbPrice.textColor = UIColor.redMainColor
        _lbDescription.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbDescription.textColor = UIColor.grayLightTextColor
        
        _tfQuantity.font = UIFont.fontRoboto(style: .Bold, size: 15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnMinusPressed(_ sender: Any) {
    }
    
    @IBAction func btnPlusPressed(_ sender: Any) {
    }
}
