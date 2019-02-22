//
//  TextViewCell.swift
//  SEM
//
//  Created by Ipman on 1/22/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {

    @IBOutlet weak var _tvInput: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _tvInput.makeBorderRound()
        _tvInput.layer.cornerRadius = 5.0
        _tvInput.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
