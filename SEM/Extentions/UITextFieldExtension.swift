import UIKit

extension UITextField{
    
    func set(textColor: UIColor, font: UIFont){
        self.textColor = textColor
        self.font = font
    }
    
    func set(placeHolder: String, color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                        attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
