//
//  TextFieldCell.swift
//  SEM
//
//  Created by Ipman on 1/22/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var _tfInput: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
