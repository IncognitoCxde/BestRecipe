//
//  CurvedTabBar.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

import UIKit

class CurvedTabBar: UITabBar {
    
    private var shapelayer: CAShapeLayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.5
        
        if let oldShapeLayer = self.shapelayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapelayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let height = self.bounds.height
        let centerWidth = self.bounds.width / 2
        let curveWidth: CGFloat = 150
        let curveDepth: CGFloat = 40
        
        let leftPoint = centerWidth - curveWidth / 2
        let rightPoint = centerWidth + curveWidth / 2

        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: leftPoint, y: 0))
        
        path.addCurve(
            to: CGPoint(x: centerWidth, y: curveDepth),
            controlPoint1: CGPoint(x: leftPoint + curveWidth * 0.20, y: 0),
            controlPoint2: CGPoint(x: centerWidth - curveWidth * 0.20, y: curveDepth)
        )
        
        path.addCurve(
            to: CGPoint(x: rightPoint, y: 0),
            controlPoint1: CGPoint(x: centerWidth + curveWidth * 0.20, y: curveDepth),
            controlPoint2: CGPoint(x: rightPoint - curveWidth * 0.20, y: 0)
        )
    
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()

        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let numberOfItems = CGFloat((items?.count ?? 0))
        let tabBarButtonClass: AnyClass? = NSClassFromString("UITabBarButton")
        var tabBarButtons: [UIView] = []

        for subview in subviews {
            if let cls = tabBarButtonClass, subview.isKind(of: cls) {
                tabBarButtons.append(subview)
            }
        }

        tabBarButtons.sort { $0.frame.origin.x < $1.frame.origin.x }

        let tabBarWidth = bounds.width
        let centerGap: CGFloat = 80
        let sideWidth = (tabBarWidth - centerGap) / numberOfItems

        for (index, button) in tabBarButtons.enumerated() {
            var frame = button.frame
            if index < Int(numberOfItems / 2) {
                frame.origin.x = sideWidth * CGFloat(index)
            } else {
                frame.origin.x = sideWidth * CGFloat(index) + centerGap
            }
            frame.size.width = sideWidth
            button.frame = frame
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 110
        return sizeThatFits
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        
    }
    
    
}
