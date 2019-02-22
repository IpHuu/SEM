//
//  BookingSubView.swift
//  SEM
//
//  Created by Ipman on 1/21/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class BookingSubView: UIView {

    @IBOutlet weak var _viewContent: UIView!
    @IBOutlet weak var _imgBGHeader: UIImageView!
    @IBOutlet weak var _imgGuard: UIImageView!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _viewMain: UIView!
    @IBOutlet weak var _lbTitle: UILabel!
    
    @IBOutlet weak var _viewSearch: UIView!
    @IBOutlet weak var _iconSearch: UIImageView!
    @IBOutlet weak var _btnNext: UIButton!
    
    @IBOutlet weak var _tfSearch: UITextField!
    @IBOutlet weak var _viewNow: UIView!
    @IBOutlet weak var _lbNow: UILabel!
    @IBOutlet weak var _viewAnother: UIView!
    @IBOutlet weak var _lbAnother: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
        initUI()
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 16)
        _lbTitle.font = UIFont.fontRoboto(style: .Regular, size: 14)

        _tfSearch.placeholder = "Vị trí bạn muốn nhân viên đến"
        _tfSearch.font = UIFont.fontRoboto(style: .Regular, size: 16)
        _tfSearch.borderStyle = .none
        _viewNow.layer.cornerRadius = 5.0
        _viewAnother.layer.cornerRadius = 5.0
        _lbNow.font = UIFont.fontRoboto(style: .Regular, size: 13)
        _lbAnother.font = UIFont.fontRoboto(style: .Regular, size: 13)
        _viewSearch.makeBorderRound()
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "BookingSubView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        return view
    }
}
