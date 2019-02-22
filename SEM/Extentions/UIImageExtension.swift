

import UIKit

extension UIImage {

    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func dottedLine(size: CGSize, lineWidth: CGFloat, color: UIColor) -> UIImage {
        
        let scale = UIScreen.main.scale
        let path = UIBezierPath()
        let  p0 = CGPoint(x: 0, y: size.height)
        path.move(to: p0)
        
        let  p1 = CGPoint(x: size.width*scale, y: size.height)
        path.addLine(to: p1)
        
        path.lineWidth = lineWidth*2
        let dash : [CGFloat] = [15, 15]
        path.setLineDash(dash, count: dash.count, phase: 0)
        
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: size.width*scale, height: size.height*scale), false, scale)
        color.setStroke()
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
}

