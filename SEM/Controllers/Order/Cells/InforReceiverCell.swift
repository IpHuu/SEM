//
//  InforReceiverCell.swift
//  SEM
//
//  Created by Ipman on 1/16/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class InforReceiverCell: UITableViewCell {

    @IBOutlet weak var _tfName: UITextField!
    @IBOutlet weak var _tfPhone: UITextField!
    @IBOutlet weak var _tfEmail: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _tfName.placeholder = "Nhập họ và tên"
        _tfPhone.placeholder = "Nhập số điện thoại"
        _tfEmail.placeholder = "Nhập email"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
