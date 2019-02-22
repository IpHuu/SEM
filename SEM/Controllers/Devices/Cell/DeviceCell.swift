//
//  DeviceCell.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var _imgProduct: UIImageView!
    @IBOutlet weak var _lbName: UILabel!
    @IBOutlet weak var _lbStatus: UILabel!
    
    @IBOutlet weak var _viewBg: UIView!
    @IBOutlet weak var _viewSwitch: UIView!
    @IBOutlet weak var _icSetting: UIButton!
    var btnSwitch: CustomSwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSwitch = CustomSwitch(frame: CGRect(x:0, y: 0, width: 40, height: 15))
        btnSwitch.isOn = false
        btnSwitch.onTintColor = UIColor.greenMainColor
        btnSwitch.offTintColor = UIColor.darkGray
        btnSwitch._cornerRadius = 0.1
        btnSwitch.thumbCornerRadius = 0.1
        btnSwitch.thumbSize = CGSize(width: 20, height: 20)
        btnSwitch.thumbTintColor = UIColor.white
        btnSwitch.addTarget(self, action: #selector(changeSwitchPressed), for: .touchUpInside)
        _viewSwitch.addSubview(btnSwitch)
        
        _viewBg.makeShadowRound()
    }
    @objc func changeSwitchPressed(){
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func icSettingTap(_ sender: Any) {
    }
    
}
