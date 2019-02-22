//
//  FooterSectionTableOrderView.swift
//  SEM
//
//  Created by Ipman on 1/23/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class FooterSectionTableOrderView: UITableViewHeaderFooterView {

    @IBOutlet weak var _lbQuantity: UILabel!
    @IBOutlet weak var _lbTotalPrice: UILabel!
    @IBOutlet weak var _lbTitleTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        _lbTotalPrice.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbTotalPrice.textColor = UIColor.redMainColor
        _lbQuantity.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbQuantity.textColor = UIColor.grayLightTextColor
        _lbTitleTotal.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbTitleTotal.textColor = UIColor.grayLightTextColor
        self.contentView.backgroundColor = UIColor.clear
    }

}
