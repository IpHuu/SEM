//
//  InfoPriceCell.swift
//  SEM
//
//  Created by Ipman on 1/4/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class InfoPriceCell: UITableViewCell {

    @IBOutlet weak var _lbTitleAmount: UILabel!
    @IBOutlet weak var _lbTitleSaleoff: UILabel!
    @IBOutlet weak var _lbTitleRest: UILabel!
    
    @IBOutlet weak var _lbAmount: UILabel!
    @IBOutlet weak var _lbSaleoff: UILabel!
    @IBOutlet weak var _lbRest: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _lbTitleAmount.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbTitleSaleoff.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbTitleRest.font = UIFont.fontRoboto(style: .Regular, size: 16)
        
        _lbTitleAmount.text = "Tổng cộng:"
        _lbTitleSaleoff.text = "Ưu đãi:"
        _lbTitleRest.text = "Còn lại:"
        
        _lbAmount.font = UIFont.fontRoboto(style: .Regular, size: 17)
        _lbSaleoff.font = UIFont.fontRoboto(style: .Regular, size: 17)
        _lbRest.font = UIFont.fontRoboto(style: .Regular, size: 17)
        
        _lbAmount.textColor = UIColor.grayLightTextColor
        _lbSaleoff.textColor = UIColor.grayMainColor
        _lbRest.textColor = UIColor.redMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
