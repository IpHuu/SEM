//
//  HeaderSectionTable.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class HeaderSectionTable: UITableViewHeaderFooterView {
    @IBOutlet weak var _lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _lbTitle.font = UIFont.fontRoboto(style: .Light, size: 16)
        _lbTitle.textColor = UIColor.blueMainColor
        self.contentView.backgroundColor = UIColor.white
    }

}
