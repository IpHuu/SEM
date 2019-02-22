//
//  ViewTabHeaderSection.swift
//  SEM
//
//  Created by Ipman on 12/27/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class ViewTabHeaderSection: UITableViewHeaderFooterView {

    @IBOutlet weak var _viewBg: UIView!
    @IBOutlet weak var _btnIntroduction: UIButton!
    @IBOutlet weak var _btnInfo: UIButton!
    @IBOutlet weak var _btnEvaluate: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        _viewBg.borderWidth = 0.5
        _viewBg.borderColor = UIColor.lightGray
        _btnIntroduction.set(backgroundColor: UIColor.clear, titleColor: UIColor.lightGray, title: "Giới thiệu", font: UIFont.fontRoboto(style: .Regular, size: 16))
        
        _btnInfo.set(backgroundColor: UIColor.clear, titleColor: UIColor.lightGray, title: "Thông số", font: UIFont.fontRoboto(style: .Regular, size: 16))
        
        _btnEvaluate.set(backgroundColor: UIColor.clear, titleColor: UIColor.lightGray, title: "Đánh giá", font: UIFont.fontRoboto(style: .Regular, size: 16))
    }
    
    func activeTab(tag: Int){
        if _btnIntroduction.tag == tag{
            _btnIntroduction.setTitleColor(UIColor.blueTextColor, for: .normal)
        }else if _btnEvaluate.tag == tag{
            _btnEvaluate.setTitleColor(UIColor.blueTextColor, for: .normal)
        }else{
            _btnInfo.setTitleColor(UIColor.blueTextColor, for: .normal)
        }
    }

}
