//
//  ButtonSOSCell.swift
//  SEM
//
//  Created by Ipman on 12/21/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class ButtonSOSCell: UITableViewCell {

    @IBOutlet weak var _viewButton: UIView!
    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _btnSOS: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Regular, size: 14)
        _viewButton.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
