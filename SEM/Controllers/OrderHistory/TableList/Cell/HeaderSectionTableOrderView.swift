//
//  HeaderSectionTableOrderView.swift
//  SEM
//
//  Created by Ipman on 1/23/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class HeaderSectionTableOrderView: UITableViewHeaderFooterView {

    @IBOutlet weak var _lbCodeOrder: UILabel!
    @IBOutlet weak var _viewBgStatus: UIView!
    @IBOutlet weak var _lbStatus: UILabel!
    @IBOutlet weak var _icStatus: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        _lbCodeOrder.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbCodeOrder.textColor = UIColor.blueMainColor
        _lbCodeOrder.text = "Mã đơn hàng: 123456"
        _lbStatus.font = UIFont.fontRoboto(style: .Light, size: 14)
        _viewBgStatus.layer.cornerRadius = 5.0
        self.contentView.backgroundColor = UIColor.clear
    }
    func updateStatus(status: Int){
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
