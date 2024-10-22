//
//  UIView+DrawShape.swift
//  YourProject
//
//  Created by IntrodexMac on 21/10/2567 BE.
//
import UIKit

extension UIView {
    func drawStraightLine(from startPoint: CGPoint,
                          to endPoint: CGPoint,
                          strokeColor: UIColor = .black,
                          lineWidth: CGFloat = 2.0,
                          alpha: Float = 1.0) // Added alpha parameter
    {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(shapeLayer)
    }
    
    func drawDashedLine(from startPoint: CGPoint,
                        to endPoint: CGPoint,
                        strokeColor: UIColor = .black,
                        lineWidth: CGFloat = 2.0,
                        lineDashPattern: [NSNumber] = [2, 2],
                        lineCap: CAShapeLayerLineCap = .butt,
                        alpha: Float = 1.0) // Added alpha parameter
    {
        let dashedLinePath = UIBezierPath()
        dashedLinePath.move(to: startPoint)
        dashedLinePath.addLine(to: endPoint)
        
        let dashedShapeLayer = CAShapeLayer()
        dashedShapeLayer.path = dashedLinePath.cgPath
        dashedShapeLayer.strokeColor = strokeColor.cgColor
        dashedShapeLayer.lineWidth = lineWidth
        dashedShapeLayer.lineDashPattern = lineDashPattern // 6 points solid, 3 points space
        dashedShapeLayer.lineCap = lineCap
        dashedShapeLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(dashedShapeLayer)
    }
    
    func drawTriangle(withPoints pointA: CGPoint,
                      pointB: CGPoint,
                      pointC: CGPoint,
                      fillColor: UIColor = .blue,
                      strokeColor: UIColor = .black,
                      lineWidth: CGFloat = 2.0,
                      alpha: Float = 1.0) // Added alpha parameter
    {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: pointA)
        trianglePath.addLine(to: pointB)
        trianglePath.addLine(to: pointC)
        trianglePath.close() // Completes the triangle
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = fillColor.cgColor // Background color for the triangle
        triangleLayer.strokeColor = strokeColor.cgColor
        triangleLayer.lineWidth = lineWidth
        triangleLayer.opacity = alpha // Set the alpha value
        
        layer.addSublayer(triangleLayer)
    }
    
    func drawCircle(at center: CGPoint,
                    radius: CGFloat = 2,
                    color: UIColor = .black,
                    strokeColor: UIColor = .black,
                    lineWidth: CGFloat = 2.0,
                    alpha: Float = 0.5) {
        // Create a circular path
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true)
        
        // Create a CAShapeLayer to hold the path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = color.cgColor // Set the circle fill color
        circleLayer.strokeColor = strokeColor.cgColor // Set the border color (optional)
        circleLayer.lineWidth = lineWidth // Set the border width
        circleLayer.opacity = alpha // Set opacity to 1.0 for full visibility
        
        // Add the circle layer to the view's layer
        self.layer.addSublayer(circleLayer)
    }
    
    func drawHorizontalCapsule(at centerPoint: CGPoint,
                               width: CGFloat,
                               height: CGFloat,
                               color: UIColor = .black,
                               strokeColor: UIColor = .black,
                               lineWidth: CGFloat = 2.0,
                               alpha: Float = 0.5) {
        // Calculate the origin based on the center point
        let originX = centerPoint.x - (width / 2)
        let originY = centerPoint.y - (height / 2)
        let capsulePath = UIBezierPath(roundedRect: CGRect(x: originX, y: originY, width: width, height: height), cornerRadius: height / 2)
        
        let capsuleLayer = CAShapeLayer()
        capsuleLayer.path = capsulePath.cgPath
        capsuleLayer.fillColor = color.cgColor
        capsuleLayer.strokeColor = strokeColor.cgColor
        capsuleLayer.lineWidth = lineWidth
        capsuleLayer.opacity = alpha
        
        self.layer.addSublayer(capsuleLayer)
    }
}
