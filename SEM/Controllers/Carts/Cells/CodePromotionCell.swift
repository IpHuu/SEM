//
//  CodePromotionCell.swift
//  SEM
//
//  Created by Ipman on 1/4/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
protocol CodePromotionCellDelegate{
    func didPressedBtnConfirm(code: String)
    func didEmptyCodeString()
}
class CodePromotionCell: UITableViewCell {

    @IBOutlet weak var _btnConfirm: UIButton!
    @IBOutlet weak var _tfCode: UITextField!
    var delegate: CodePromotionCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _btnConfirm.set(backgroundColor: UIColor.blueMainColor, titleColor: UIColor.white, title: "Áp dụng", font: UIFont.fontRoboto(style: .Medium, size: 14))
        _btnConfirm.layer.cornerRadius = 5.0
        _tfCode.placeholder = "Nhập mã khuyến mãi"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnConfirmPressed(_ sender: Any) {
        if (_tfCode.text?.isEmpty)!{
            delegate.didEmptyCodeString()
            return
        }
        delegate.didPressedBtnConfirm(code: _tfCode.text!)
    }
    
}
