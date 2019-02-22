//
//  EvaluateCell.swift
//  SEM
//
//  Created by Ipman on 1/14/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import AARatingBar
class EvaluateCell: UITableViewCell {

    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _viewRating: AARatingBar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _viewRating.maxValue = 5
        _viewRating.value = 0
        _viewRating.color = UIColor.yellowMainColor
        
        _lbTitle.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _lbTitle.text = "Đánh giá của bạn"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
