import UIKit

extension UIButton{
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x:0.0,y:0.0,width: 1.0,height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func setBackgroundColor(color: UIColor, forUIControlState state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
    func setBorderColor(borderColor: UIColor,
                        borderWidth: CGFloat,
                        titleColor: UIColor,
                        title: String,
                        font: UIFont=UIFont.systemFont(ofSize: UIFont.systemFontSize),
                        cornerRadius: CGFloat?=nil){
        self.backgroundColor = UIColor.clear
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = font
        if let cornerRadius = cornerRadius{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func setStyle(backgroundColor: UIColor,
                  titleColor: UIColor,
                  title: String,
                  font: UIFont=UIFont.systemFont(ofSize: UIFont.systemFontSize)){
        self.layoutIfNeeded()
        self.set(backgroundColor: backgroundColor,
                      titleColor: titleColor,
                      title: title,
                      font: font,
                      cornerRadius: self.height/2)
    }
    
    func set(backgroundColor: UIColor,
             titleColor: UIColor,
             title: String,
             font: UIFont=UIFont.systemFont(ofSize: UIFont.systemFontSize),
             cornerRadius: CGFloat?=nil){
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = font
        if let cornerRadius = cornerRadius{
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    
    //    This method sets an image and title for a UIButton and
    //    repositions the titlePosition with respect to the button image.
    //    Add additionalSpacing between the button image & title as required
    //    For titlePosition, the function only respects UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft and UIViewContentModeRight
    //    All other titlePositions are ignored
    @objc func set(image anImage: UIImage?, title: String, titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode, spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }

    func circle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
}
