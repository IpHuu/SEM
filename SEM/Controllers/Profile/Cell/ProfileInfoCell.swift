//
//  ProfileInfoCell.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class ProfileInfoCell: UITableViewCell {

    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _lbValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbTitle.textColor = UIColor.blueMainColor
        
        _lbValue.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _lbValue.textColor = UIColor.blueMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
