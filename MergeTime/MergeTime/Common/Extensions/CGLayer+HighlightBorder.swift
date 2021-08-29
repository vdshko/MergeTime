import UIKit

extension CGLayer {
    
    static func highlightBorder(width: CGFloat, height: CGFloat) -> CAShapeLayer {
        let margin: CGFloat = 3
        
        let cornerPath = UIBezierPath()
        
        // rightTopCorner
        cornerPath.move(to: CGPoint(x: (width - width / 4), y: 0))
        cornerPath.addLine(to: CGPoint(x: width, y: 0))
        cornerPath.addLine(to: CGPoint(x: width, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: height / 4))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: margin))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: margin))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: 0))
        
        // rightBottomCorner
        cornerPath.move(to: CGPoint(x: (width - width / 4), y: height))
        cornerPath.addLine(to: CGPoint(x: width, y: height))
        cornerPath.addLine(to: CGPoint(x: width, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: height))
        
        // leftTopCorner
        cornerPath.move(to: CGPoint(x: 0, y: 0))
        cornerPath.addLine(to: CGPoint(x: 0, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: margin, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: margin, y: margin))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: margin))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: 0))
        cornerPath.addLine(to: CGPoint(x: 0, y: 0))
        
        // leftBottomCorner
        cornerPath.move(to: CGPoint(x: 0, y: height))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: height))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: margin, y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: margin, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: 0, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: 0, y: height))
        
        let layer = CAShapeLayer()
        layer.path = cornerPath.cgPath
        layer.strokeColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColor
        layer.fillColor = Asset.Colors.Specific.itemMaxLevelTint.color.cgColor
        layer.lineWidth = 0.5
        
        return layer
    }
}
