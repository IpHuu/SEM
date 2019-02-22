//
//  ProductSummaryCell.swift
//  SEM
//
//  Created by Ipman on 12/25/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import AARatingBar
class ProductSummaryCell: UITableViewCell {

    @IBOutlet weak var _viewRating: AARatingBar!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbPrice: UILabel!
    
    @IBOutlet weak var _lbPointRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _viewRating.maxValue = 5
        _viewRating.value = 1.5
        _viewRating.color = UIColor.yellowMainColor
        _viewRating.isEnabled = false
        _lbName.font = UIFont.fontRoboto(style: .Bold, size: 25)
        _lbPrice.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _lbPrice.textColor = UIColor.redMainColor
        _lbPointRating.font = UIFont.fontRoboto(style: .Light, size: 14)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
