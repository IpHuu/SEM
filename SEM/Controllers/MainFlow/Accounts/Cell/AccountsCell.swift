//
//  AccountsCell.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class AccountsCell: UITableViewCell {

    @IBOutlet weak var _icCell: UIImageView!
    @IBOutlet weak var _lbCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbCell.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbCell.textColor = UIColor.blueMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
