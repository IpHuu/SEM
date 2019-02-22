//
//  HeaderTableViewProducts.swift
//  SEM
//
//  Created by Ipman on 12/21/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class HeaderTableViewProducts: UITableViewHeaderFooterView {

    @IBOutlet weak var _lbTilte: UILabel!
    @IBOutlet weak var _lbMore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        _lbTilte.font = UIFont.fontRoboto(style: .Bold, size: 18)
        _lbMore.font = UIFont.fontRoboto(style: .Light, size: 15)
        self.contentView.backgroundColor = UIColor.white
    }
}
