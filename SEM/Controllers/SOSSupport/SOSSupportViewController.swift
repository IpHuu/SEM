//
//  SOSSupportViewController.swift
//  SEM
//
//  Created by Ipman on 1/8/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit

class SOSSupportViewController: BaseViewController {

    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _tvNote: UITextView!
    @IBOutlet weak var _imgSOS: UIImageView!
    @IBOutlet weak var _btnCallSupport: UIButton!
    @IBOutlet weak var _lbIntroduction: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI(){
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 20)
        _lbHeader.text = "Báo cáo sự cố"
        _tvNote.placeholder = "Giải thích ngắn gọn về sự cố bạn gặp phải"
        _tvNote.placeholderColor = UIColor.grayMainColor
        _tvNote.font = UIFont.fontRoboto(style: .Light, size: 14)
        
        _btnCallSupport.set(backgroundColor: UIColor.redMainColor, titleColor: UIColor.white, title: "GỌI HỖ TRỢ NGAY", font: UIFont.fontRoboto(style: .Bold, size: 20))
        _btnCallSupport.layer.cornerRadius = 5.0
        
        _lbIntroduction.text =  "Chúng tôi sẽ có mặt ngay để hỗ trợ bạn kịp thời"
        _lbIntroduction.font = UIFont.fontRoboto(style: .Regular, size: 16)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.0,
                       options: [.repeat], animations: {
                        self._imgSOS.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (_) in
            
        }
    }
    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
