//
//  InfoCell.swift
//  SEM
//
//  Created by Ipman on 1/25/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Bold, size: 14)
        _lbContent.font = UIFont.fontRoboto(style: .Regular, size: 14)
        _lbContent.textColor = UIColor.blueMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
