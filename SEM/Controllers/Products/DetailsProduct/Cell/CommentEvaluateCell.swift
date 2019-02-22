//
//  CommentEvaluateCell.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import AARatingBar
class CommentEvaluateCell: UITableViewCell {

    @IBOutlet weak var _imgAvatar: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbTime: UILabel!
    
    @IBOutlet weak var _viewRating: AARatingBar!
    @IBOutlet weak var _lbComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _viewRating.maxValue = 5
        _viewRating.value = 4
        _viewRating.color = UIColor.yellowMainColor
        _viewRating.isEnabled = false
        
        _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.height/2
        _imgAvatar.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
