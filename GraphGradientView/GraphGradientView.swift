//
//  GraphGradientView.swift
//  GraphGradientView
//
//  Created by Ацамаз Бицоев on 27/04/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class GraphGradientView: UIView {
    
    
    @IBInspectable var color1: UIColor = #colorLiteral(red: 0.1405102015, green: 0.4976266623, blue: 0.7326892614, alpha: 1)
    @IBInspectable var color2: UIColor = #colorLiteral(red: 0.01166653726, green: 0.6717716455, blue: 0.7564669251, alpha: 1)
    
    @IBInspectable var topMargin: CGFloat = 19
    @IBInspectable var bottomMargin: CGFloat = 31
    @IBInspectable var leftMargin: CGFloat = 32
    @IBInspectable var rightMargin: CGFloat = 34
    
    @IBInspectable var dotRadius: CGFloat = 1
    
    var values: [CGFloat]?

    
    override func draw(_ rect: CGRect) {
        
        addGradient(color1: color1, color2: color2)
        drawLines()
        drawDots(for: values)
        
    }
    
    
    private func addGradient(color1: UIColor, color2: UIColor) {
        
        let context = UIGraphicsGetCurrentContext()!
        let colors = [color1.cgColor, color2.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0, 1]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint(x: 0, y: 1.25 * bounds.height)
        let endPoint = CGPoint(x: bounds.width, y: -0.25 * (bounds.height))
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    
    private func drawLines() {
        
        let lineLength = bounds.width - leftMargin - rightMargin
        let lineWidth: CGFloat = 1
        let masCentersOfLines = getCentersOfLines()
        
        for lineCenter in masCentersOfLines {
            drawOneLine(width: lineWidth, length: lineLength, center: lineCenter)
        }
    }
    
    private func getCentersOfLines() -> [CGPoint] {
        
        let centerX = bounds.width * 0.5
        let center0Y = topMargin
        let center2Y = bounds.height - bottomMargin
        let center1Y = (center0Y + center2Y) * 0.5
        
        let masCentersOfLines = [CGPoint(x: centerX, y: center0Y),
                                 CGPoint(x: centerX, y: center1Y),
                                 CGPoint(x: centerX, y: center2Y)]
        return masCentersOfLines
    }
    
    private func drawOneLine(width: CGFloat, length: CGFloat, center: CGPoint) {
        
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: center.x - length / 2,
                                  y: center.y))
        linePath.addLine(to: CGPoint(x: center.x + length / 2,
                                     y: center.y))
        linePath.close()
        
        linePath.lineWidth = 1
        UIColor(white: 1, alpha: 0.5).setStroke()
        linePath.stroke()
    }
    
    private func drawDots(for values: [CGFloat]?) {
        
        guard let values = values, values.count != 0 else { return }
        
        let centersOfDots = getCentersOfDots(for: values)
        for center in centersOfDots {
            drawDot(at: center)
        }
    }
    
    private func getCentersOfDots(for values: [CGFloat]) -> [CGPoint] {
        
        var centers: [CGPoint] = []
        
        let verticalMultiplier = (bounds.height - topMargin - bottomMargin) / values.max()!
        let horizontalInset = (bounds.width - leftMargin - rightMargin) / CGFloat(values.count - 1)
        
        for i in 0..<values.count {
            
            let bottomInsetOfCenter = bottomMargin + values[i] * verticalMultiplier
            
            let center = CGPoint(x: leftMargin + CGFloat(i) * horizontalInset,
                                 y: bounds.height - bottomInsetOfCenter)
            centers.append(center)
        }
        print(centers)
        return centers
    }
    
    private func drawDot(at center: CGPoint) {
        
        let dotRect = CGRect(x: center.x - dotRadius,
                             y: center.y - dotRadius,
                             width: dotRadius * 2,
                             height: dotRadius * 2)
        
        let dotPath = UIBezierPath(ovalIn: dotRect)
        UIColor.white.setFill()
        dotPath.fill()
        
    }
    

}
