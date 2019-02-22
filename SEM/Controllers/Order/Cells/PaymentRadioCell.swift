//
//  PaymentRadioCell.swift
//  SEM
//
//  Created by Ipman on 1/15/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class PaymentRadioCell: UITableViewCell {

    @IBOutlet weak var _radioButton: UIButton!
    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _lbDescription: UILabel!
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                let selectedImage = UIImage(named: "ic_CheckedRadial")?.withRenderingMode(.alwaysOriginal)
                _radioButton.setImage(selectedImage, for: .normal)
            }else{
                let deselectedImage = UIImage(named: "ic_UncheckRadial")?.withRenderingMode(.alwaysOriginal)
                _radioButton.setImage(deselectedImage, for: .normal)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Regular, size: 14)
        _lbDescription.font = UIFont.fontRoboto(style: .Light, size: 12)
        _lbDescription.textColor = UIColor.redMainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
