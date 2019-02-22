//
//  SelectionCell.swift
//  SEM
//
//  Created by Ipman on 1/22/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class SelectionCell: UICollectionViewCell {

    @IBOutlet weak var _viewBG: UIView!
    
    @IBOutlet weak var _lbTitle: UILabel!
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                _viewBG.backgroundColor = UIColor.MethodReceive.activeBackgroundColor
                self._lbTitle.textColor = UIColor.white
            }else{
                _viewBG.backgroundColor = UIColor.MethodReceive.normalBackgroundColor
                self._lbTitle.textColor = UIColor.MethodReceive.titleColor
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbTitle.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _viewBG.backgroundColor = UIColor.MethodReceive.normalBackgroundColor
        self._lbTitle.textColor = UIColor.MethodReceive.titleColor
    }

}
