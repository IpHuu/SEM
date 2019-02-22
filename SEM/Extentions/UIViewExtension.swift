

import UIKit

extension UIView{
    func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
        
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedDefaultBorder() {
        let color = UIColor.lightGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    func addActiveBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    func makeBottomShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: -1.0 , height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
    }
    
    func makeShadowRound(){
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:1.0,height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
    }
    
    func makeBorderRound(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
    
    @IBInspectable var roundCornerIgnoreTL : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight , .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreTR : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreBL : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreBR : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight , .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.clear
        }
        set (color) {
            self.layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return 0
        }
        set (width) {
            self.layer.borderWidth = width
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return 0
        }
        set (width) {
            self.layer.cornerRadius = width
            self.layer.masksToBounds = true
        }
    }
    @IBInspectable var _radius: CGFloat {
        get {
            return 0
        }
        set (_radius) {
            self.layer.cornerRadius = _radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return self.layer.cornerRadius == min(self.frame.width, self.frame.height) / 2
        }
        set(value) {
            if value == true {
                self.clipsToBounds = true
                self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get { return UIColor(cgColor: self.layer.shadowColor ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor) }
        set (color) { self.layer.shadowColor = color.cgColor }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set (offset) { self.layer.shadowOffset = offset }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(self.layer.shadowOpacity) }
        set (opacity) { self.layer.shadowOpacity = Float(opacity) }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return CGFloat(self.layer.shadowRadius) }
        set (radius) { self.layer.shadowRadius = radius }
    }
    @IBInspectable var Autoradius: Bool {
        get {
            print("WARNING no getter for UIView.corner_radius")
            return false
        }
        set (_radius) {
            if(_radius){
                self.layer.cornerRadius = (self.frame.size.height * 2 * UIScreen.main.bounds.size.width/320.0)/2
                self.layer.masksToBounds = true
            }
        }
    }
}

@IBDesignable
class RadialGradientView: UIView {
    
    @IBInspectable var InsideColor: UIColor = UIColor.clear
    @IBInspectable var OutsideColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let colors = [InsideColor.cgColor, OutsideColor.cgColor] as CFArray
        let endRadius = min(frame.width, frame.height) / 2
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
}

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
