//
//  OrderSummaryCell.swift
//  SEM
//
//  Created by Ipman on 1/24/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
enum StatusOrder: Int{
    case cancel,
    success,
    delivered,
    done
}
class OrderSummaryCell: UITableViewCell {

    @IBOutlet weak var _lbCode: UILabel!
    @IBOutlet weak var _viewBgStatus: UIView!
    @IBOutlet weak var _lbStatus: UILabel!
    @IBOutlet weak var _icStatus: UIImageView!
    @IBOutlet weak var _lbTitleAddress: UILabel!
    @IBOutlet weak var _lbAddress: UILabel!
    @IBOutlet weak var _lbTitleTime: UILabel!
    @IBOutlet weak var _lbTime: UILabel!
    @IBOutlet weak var _lbQuantity: UILabel!
    @IBOutlet weak var _lbTotalPrice: UILabel!
    @IBOutlet weak var _lbTitleTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _lbCode.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbCode.textColor = UIColor.blueMainColor
        _lbCode.text = "Mã đơn hàng: 123456"
        _lbStatus.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbTitleTime.font = UIFont.fontRoboto(style: .Bold, size: 15)
        _lbTitleAddress.font = UIFont.fontRoboto(style: .Bold, size: 15)

        _lbAddress.font = UIFont.fontRoboto(style: .Regular, size: 15)
        _lbAddress.textColor = UIColor.grayLightTextColor
        _lbTime.textColor = UIColor.grayLightTextColor
        _lbTime.font = UIFont.fontRoboto(style: .Regular, size: 15)
        
        _lbTotalPrice.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbTotalPrice.textColor = UIColor.redMainColor
        _lbQuantity.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbQuantity.textColor = UIColor.grayLightTextColor
        _lbTitleTotal.font = UIFont.fontRoboto(style: .Light, size: 14)
        _lbTitleTotal.textColor = UIColor.grayLightTextColor
        
        _viewBgStatus.layer.cornerRadius = 5.0
        
        _lbTitleAddress.text = "Địa chỉ:"
        _lbTitleTime.text = "Thời gian:"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateStatusOrder(status: Int){
        let statusOrder = StatusOrder(rawValue: status)!
        switch statusOrder {
        case .cancel:
            _viewBgStatus.backgroundColor = UIColor.redMainColor
            _lbStatus.text = "Hủy"
            _icStatus.image = #imageLiteral(resourceName: "Canceled")
        case .delivered:
            _viewBgStatus.backgroundColor = UIColor.blueMainColor
            _lbStatus.text = "Đang giao"
            _icStatus.image = #imageLiteral(resourceName: "OnProgress")
        case .success:
            _viewBgStatus.backgroundColor = UIColor.yellowMainColor
            _lbStatus.text = "Đã tạo"
            _icStatus.image = #imageLiteral(resourceName: "Done")
        case .done:
            _viewBgStatus.backgroundColor = UIColor.greenMainColor
            _lbStatus.text = "Hoàn tất"
            _icStatus.image = #imageLiteral(resourceName: "Done")
        }
    }
    
}
