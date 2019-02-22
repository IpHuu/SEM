

import UIKit

extension UILabel {

    func set(textColor: UIColor, font: UIFont){
        self.textColor = textColor
        self.font = font
    }
    func setText(text: String="", withColor color: UIColor = UIColor.black, textAlignment: NSTextAlignment = .left, fontSize: CGFloat=UIFont.labelFontSize){
        self.text = text
        self.textColor = color
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}
