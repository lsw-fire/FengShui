//
//  EightTrigramDrawView.swift
//  fengshui
//
//  Created by Li Shi Wei on 20/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

 @IBDesignable class EightTrigramDrawView: UIView {
    
    var fillColor: UIColor = UIColor.orange

    var widthForShow: CGFloat = 0
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let width = widthForShow == 0 ? self.frame.width : widthForShow
        
        let context = UIGraphicsGetCurrentContext();
        
        let center = CGPoint(x: width/2, y: width/2)
        let radius = CGFloat(width/2)
        
        let begin =
             (0.125 + 0.0625) * M_PI * 2
        let end =
            ((0.125 + 0.0625) + 0.125) * M_PI * 2
        
        context?.setFillColor(fillColor.cgColor)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.addArc(center: center, radius: radius, startAngle: CGFloat(begin), endAngle: CGFloat(end), clockwise: false)
        context?.addLine(to: center)
        context?.drawPath(using: .fillStroke)
        
        //把圆边去了，只显示八角形
        context?.setFillColor(UIColor.white.cgColor)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.addArc(center: center, radius: radius, startAngle: CGFloat(begin), endAngle: CGFloat(end), clockwise: false)
        
        context?.drawPath(using: .fillStroke)

        
    }
 

}
