//
//  InnerView.swift
//  fengshui
//
//  Created by Li Shi Wei on 20/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

@IBDesignable class InnerView: UIView {

    var widthForShow: CGFloat = 0
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let width = widthForShow == 0 ? self.frame.width : widthForShow
        
        let context = UIGraphicsGetCurrentContext();
        
        let center = CGPoint(x: width/2, y: width/2)
        let radius = CGFloat(width/2)
        
        context?.setFillColor(UIColor.white.cgColor)
        
        let begin = 0
        
        let end = M_PI * 2
        
        context?.addArc(center: center, radius: radius, startAngle: CGFloat(begin), endAngle: CGFloat(end), clockwise: false)
        context?.addLine(to: center)
        context?.drawPath(using: .fill)
        
       
    }
 

}
