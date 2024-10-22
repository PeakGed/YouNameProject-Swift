//
//  PriceTarget.swift
//  YourProject
//
//  Created by IntrodexMac on 22/10/2567 BE.
//

import Foundation
import UIKit

struct PriceTargetVM {
    let startPoint: CGPoint
    let startNowShape: Circle
        
    let endMaxShape: Circle?
    let endAboveNowShape: [Circle]
    let endNowShape: Circle
    var endBelowNowShape: [Circle]
    let endAvgShape: HorizontalCapsule?
    let endMinShape: Circle?

    let maxLine: Line?
    let nowLine: SolidLine
    let avgLine: Line?
    let minLine: Line?

    // StartPoint to EndNowPoint to EndMaxPoint
    let upperTriagle: Triangle?
    
    // StartPoint to EndNowPoint to EndMinPoint
    let lowerTriagle: Triangle?
    
    
    init(startPoint: CGPoint,
         endX: CGFloat,
         yValues: [CGFloat],
         yAvg: CGFloat?) {
        self.startPoint = startPoint
        
        // Initialize shapes based on the provided yValues
        startNowShape = Circle.startCurrentPrice(center: startPoint)
        
        let endNowPoint = CGPoint(x: endX, y: startPoint.y)
        endNowShape = Circle.endCurrentPrice(center: endNowPoint)
        
        // Determine the end max point , use min to get max value
        let endMaxPoint = yValues.min().map { CGPoint(x: endX, y: $0) }
        //endMaxShape = endMaxPoint.map { Circle.endMaxPrice(center: $0) }
        if let endMaxPoint {
            //lower
            if endMaxPoint.y < startPoint.y {
                endMaxShape = Circle.endBelowMaxPrice(center: endMaxPoint)
                upperTriagle = nil
            }
            //upper
            else if endMaxPoint.y > startPoint.y {
                endMaxShape = Circle.endAboveMaxPrice(center: endMaxPoint)
                
                // check is maxPrice is not higher then nowPrice
                upperTriagle = Triangle.aboveCurrentPrice(startPoint: startPoint,
                                                          secondPoint: endNowPoint,
                                                          endPoint: endMaxPoint)
            }
            else {
                endMaxShape = nil
                upperTriagle = nil
            }
        }
        else {
            endMaxShape = nil
            upperTriagle = nil
        }
                
        // Determine the end min point , use max to get min value
        let endMinPoint = yValues.max().map { CGPoint(x: endX, y: $0) }
        
        if let endMinPoint {
            //lower
            if endMinPoint.y < startPoint.y {
                endMinShape = Circle.endBelowMinPrice(center: endMinPoint)
                
                // check is minPrice is not lower then nowPrice
                lowerTriagle = Triangle.belowCurrentPrice(startPoint: startPoint,
                                                          secondPoint: endNowPoint,
                                                          endPoint: endMinPoint)
            }
            //upper
            else if endMinPoint.y > startPoint.y {
                endMinShape = Circle.endAboveCurrentPrice(center: endMinPoint)
                lowerTriagle = nil
            }
            else {
                endMinShape = nil
                lowerTriagle = nil
            }
        }
        else {
            endMinShape = nil
            lowerTriagle = nil
        }
        
        // Create end above now shapes , use filter to get values above start point
        let endYAboveNow = yValues.filter { $0 < startPoint.y }
        endAboveNowShape = endYAboveNow.map { Circle.endAboveCurrentPrice(center: CGPoint(x: endX, y: $0)) }
        
        // Create end below now shapes , use filter to get values below start point
        let endYBelowNow = yValues.filter { $0 > startPoint.y }
        endBelowNowShape = endYBelowNow.map { Circle.endBelowCurrentPrice(center: CGPoint(x: endX, y: $0)) }
        
      
        // Line
        nowLine = SolidLine.currentPriceLine(from: startPoint,
                                             to: endNowPoint)
        
        maxLine = endMaxPoint.map { DashLine.aboveDashLine(from: startPoint,
                                                           to: $0) }
        
        // Determine the end average point
        let endAvgPoint = yAvg.map { CGPoint(x: endX, y: $0) }
        
        if let endAvgPoint {
            if endAvgPoint.y > startPoint.y {
                endAvgShape = HorizontalCapsule.endAvgPriceBelowNow(center: endAvgPoint)
                
                avgLine = DashLine.belowDashLine(from: startPoint,
                                                 to: endAvgPoint)
            }
            else if endAvgPoint.y < startPoint.y {
                endAvgShape = HorizontalCapsule.endAvgPriceAboveNow(center: endAvgPoint)
                avgLine = DashLine.aboveDashLine(from: startPoint,
                                                 to: endAvgPoint)
            }
            else {
                endAvgShape = nil
                avgLine = nil
            }
        }
        else {
            endAvgShape = nil
            avgLine = nil
        }
        
        
        minLine = endMinPoint.map { DashLine.belowDashLine(from: startPoint,
                                                           to: $0) }

        // Create triangles if applicable
        
        
      
        
    }
//
//    init(startPoint: CGPoint,
//         endX: CGFloat,
//         endYAboveNow: [CGFloat],
//         endYBelowNow: [CGFloat],
//         endYMax: CGFloat?,
//         endYMin: CGFloat?,
//         endYAvg: CGFloat?,
//         avgMoreThenNow: Bool?)
//    {
//        self.startPoint = startPoint
//
//        // init shape
//
//        startNowShape = Circle.startCurrentPrice(center: startPoint)
//
//        let endNowPoint = CGPoint(x: endX,
//                                  y: startPoint.y)
//
//        endNowShape = Circle.endCurrentPrice(center: endNowPoint)
//
//        let endMaxPoint = endYMax.map {
//            CGPoint(x: endX,
//                    y: $0)
//        }
//
//        endMaxShape = (endMaxPoint != nil) ? Circle.endMaxPrice(center: endMaxPoint!) : nil
//
//        let endAboveNowPoint = endYAboveNow.map {
//            CGPoint(x: endX,
//                    y: $0)
//        }
//        endAboveNowShape = endAboveNowPoint.map {
//            Circle.endAboveCurrentPrice(center: $0)
//        }
//
//        let endMinPoint = endYMin.map {
//            CGPoint(x: endX,
//                    y: $0)
//        }
//        if let endMinPoint {
//            endMinShape = Circle.endMinPrice(center: endMinPoint)
//        }
//        else {
//            endMinShape = nil
//        }
//
//        let endbelowNowPoint = endYBelowNow.map {
//            CGPoint(x: endX,
//                    y: $0)
//        }
//        endBelowNowShape = endbelowNowPoint.map {
//            Circle.endBelowCurrentPrice(center: $0)
//        }
//
//        let endAvgPoint = endYAvg.map {
//            CGPoint(x: endX,
//                    y: $0)
//        }
//        if let endAvgPoint,
//           let avgMoreThenNow {
//            if avgMoreThenNow {
//                endAvgShape = HorizontalCapsule.endAvgPriceAboveNow(center: endAvgPoint)
//            }
//            else {
//                endAvgShape = HorizontalCapsule.endAvgPriceBelowNow(center: endAvgPoint)
//            }
//        }
//        else {
//            endAvgShape = nil
//        }
//
//        // Line
//        if let endMaxPoint {
//            maxLine = DashLine.aboveDashLine(from: startPoint,
//                                             to: endMaxPoint)
//        }
//        else {
//            maxLine = nil
//        }
//
//        nowLine = SolidLine.currentPriceLine(from: startPoint,
//                                             to: endNowPoint)
//
//        if let endMinPoint {
//            minLine = DashLine.belowDashLine(from: startPoint,
//                                             to: endMinPoint)
//        }
//        else {
//            minLine = nil
//        }
//
//
//        // above current price
//        if let endAvgPoint {
//            // invert logic
//            if endAvgPoint.y < endNowPoint.y {
//                avgLine = DashLine.aboveDashLine(from: startPoint,
//                                                 to: endAvgPoint)
//            } else if endAvgPoint.y > endNowPoint.y {
//                avgLine = DashLine.belowDashLine(from: startPoint,
//                                                 to: endAvgPoint)
//            } else {
//                avgLine = nil
//            }
//        }
//        else {
//            avgLine = nil
//        }
//
//        // Triangle
//        upperTriagle = endMaxPoint.map { Triangle.aboveCurrentPrice(startPoint: startPoint,
//                                                                    secondPoint: endNowPoint,
//                                                                    endPoint: $0) }
//
//        lowerTriagle = endMinPoint.map { Triangle.belowCurrentPrice(startPoint: startPoint,
//                                                                    secondPoint: endNowPoint,
//                                                                    endPoint: $0) }
//
//    }
}

protocol Shape {
    func draw(on view: UIView)
}

struct Circle: Shape {
    let center: CGPoint
    let radius: CGFloat
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(center: CGPoint,
         radius: CGFloat,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 0.5,
         alpha: Float = 1.0)
    {
        self.center = center
        self.radius = radius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawCircle(at: center,
                        radius: radius,
                        color: fillColor,
                        strokeColor: strokeColor,
                        lineWidth: lineWidth,
                        alpha: alpha)
    }
    
    static func startCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 0.5,
                     alpha: 1)
    }
    
    static func endCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .gray,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endAboveMaxPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endBelowMaxPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .orange,
                     strokeColor: .black,
                     lineWidth: 1,
                        alpha: 1)
    }
    
    static func endAboveCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .green,
                     lineWidth: 0.5,
                     alpha: 0.5)
    }
    
    static func endBelowCurrentPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .orange,
                     strokeColor: .orange,
                     lineWidth: 0.5,
                     alpha: 0.5)
    }
    
    static func endAboveMinPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 2.5,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endBelowMinPrice(center: CGPoint) -> Self {
        return .init(center: center,
                     radius: 3,
                     fillColor: .orange,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
}

struct HorizontalCapsule: Shape {
    let center: CGPoint
    let width: CGFloat
    let height: CGFloat
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(center: CGPoint,
         width: CGFloat = 20,
         height: CGFloat = 10,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 1.0,
         alpha: Float = 1.0)
    {
        self.center = center
        self.width = width
        self.height = height
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawHorizontalCapsule(at: center,
                                   width: width,
                                   height: height,
                                   color: fillColor,
                                   strokeColor: strokeColor,
                                   lineWidth: lineWidth,
                                   alpha: alpha)
    }
    
    static func endAvgPriceAboveNow(center: CGPoint) -> Self {
        return .init(center: center,
                     width: 7,
                     height: 3,
                     fillColor: .green,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
    
    static func endAvgPriceBelowNow(center: CGPoint) -> Self {
        return .init(center: center,
                     width: 7,
                     height: 3,
                     fillColor: .red,
                     strokeColor: .black,
                     lineWidth: 1,
                     alpha: 1)
    }
}

struct Triangle: Shape {
    let startPoint: CGPoint
    let secondPoint: CGPoint
    let endPoint: CGPoint
    let fillColor: UIColor
    let strokeColor: UIColor
    let lineWidth: CGFloat
    let alpha: Float

    init(startPoint: CGPoint,
         secondPoint: CGPoint,
         endPoint: CGPoint,
         fillColor: UIColor = .black,
         strokeColor: UIColor = .black,
         lineWidth: CGFloat = 0.5,
         alpha: Float = 1.0)
    {
        self.startPoint = startPoint
        self.secondPoint = secondPoint
        self.endPoint = endPoint
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.alpha = alpha
    }

    func draw(on view: UIView) {
        view.drawTriangle(withPoints: startPoint,
                          pointB: secondPoint,
                          pointC: endPoint,
                          fillColor: fillColor,
                          strokeColor: strokeColor,
                          lineWidth: lineWidth,
                          alpha: alpha)
    }
    
    static func aboveCurrentPrice(startPoint: CGPoint,
                                  secondPoint: CGPoint,
                                  endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     secondPoint: secondPoint,
                     endPoint: endPoint,
                     fillColor: .green,
                     strokeColor: .green,
                     lineWidth: 1,
                     alpha: 0.5)
    }
    
    static func belowCurrentPrice(startPoint: CGPoint,
                                  secondPoint: CGPoint,
                                  endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     secondPoint: secondPoint,
                     endPoint: endPoint,
                     fillColor: .orange,
                     strokeColor: .orange,
                     lineWidth: 1,
                     alpha: 0.5)
    }
            
}

protocol Line {
    func draw(on view: UIView)
}

struct SolidLine: Line {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let strokeColor: UIColor = .black
    let lineWidth: CGFloat
    let alpha: Float
    
    func draw(on view: UIView) {
        view.drawStraightLine(from: startPoint,
                              to: endPoint,
                              strokeColor: strokeColor,
                              lineWidth: lineWidth,
                              alpha: alpha)
    }
    
    static func currentPriceLine(from startPoint: CGPoint,
                                 to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     lineWidth: 1.0,
                     alpha: 1.0)
    }
}

struct DashLine: Line {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let style: CAShapeLayerLineCap
    let lineWidth: CGFloat
    let lineColor: UIColor
    let alpha: Float
    let lineDashPattern: [NSNumber] = [4, 4]

    func draw(on view: UIView) {
        view.drawDashedLine(from: startPoint,
                            to: endPoint,
                            strokeColor: lineColor,
                            lineWidth: lineWidth,
                            lineDashPattern: lineDashPattern,
                            lineCap: style,
                            alpha: alpha)
    }
    
    static func aboveDashLine(from startPoint: CGPoint,
                              to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     style: .round,
                     lineWidth: 1,
                     lineColor: .green,
                     alpha: 1)
    }
    
    static func belowDashLine(from startPoint: CGPoint,
                              to endPoint: CGPoint) -> Self {
        return .init(startPoint: startPoint,
                     endPoint: endPoint,
                     style: .round,
                     lineWidth: 1,
                     lineColor: .orange,
                     alpha: 1)
    }
}
