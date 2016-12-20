//
//  TriangelView.swift
//  fengshui
//
//  Created by Li Shi Wei on 19/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

@IBDesignable class TriangelView: UIView {
    
    
    var widthForShow: CGFloat = 0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        
        //context?.setFillColor(UIColor.lightGray.cgColor)
        /*画三角形*/
        
        //只要三个点就行跟画一条线方式一样，把三点连接起来
        
        //var sPoints = [CGPoint]()  //坐标点
        
        let width = widthForShow
        let height = widthForShow
        
        
        //        sPoints.append( CGPoint(x: width/2, y: 0))//坐标1
        //
        //        sPoints.append(CGPoint(x:0, y:height));//坐标2
        //
        //        sPoints.append(CGPoint(x:width, y:height));//坐标3
        //
        //        context?.addLines(between: sPoints)  //添加线
        //
        //        context?.closePath() //封起来
        //
        //        context?.drawPath(using: .stroke) //根据坐标绘制路径
        //
        //        let d = calculateAngle(x1: 50, y1: 0, x2: 0, y2: 50)
        //
        //        print(d)
        
        let center = CGPoint(x: width/2, y: height/2)
        let radius = CGFloat(width/2)
        //let startAngle = CGFloat(0)
        let endAngle = CGFloat(2 * M_PI)
        
        
        //        context?.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        
        
        
        
        //context?.drawPath(using: .stroke)
        var color = UIColor.orange
        //var startAngle = 0
        
        for i in 1...1 {
            if i%2 == 0 {
                color = UIColor.lightGray
            }else{
                color = UIColor.orange
            }
            
            context?.setFillColor(color.cgColor)
            //context?.setLineWidth(CGFloat(3))
            
            let sa = Double(i) * (0.125 + 0.0625) * M_PI * 2
            let end = (Double(i) * 0.1875 + 0.125) * M_PI * 2
            
            context?.addArc(center: center, radius: radius, startAngle: CGFloat(sa), endAngle: CGFloat(end), clockwise: false)
            context?.addLine(to: center)
            context?.drawPath(using: .fill)
            
            //把圆边去了，只显示八角形
            context?.setFillColor(UIColor.white.cgColor)
            //context?.setStrokeColor(UIColor.white.cgColor)
            context?.addArc(center: center, radius: radius, startAngle: CGFloat(sa), endAngle: CGFloat(end), clockwise: false)
            context?.drawPath(using: .fillStroke)
            
//            let x =  (width/2) * sin(22.5) + (width/2)
//            //-163  171  35156
//            let y = (width/2) * cos(22.5) + (height/2)
//            //-91   77
//            print(x)
//            print(y)
            
            
//            let lb = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 80))
//            lb.text = "延年"
//            lb.textAlignment = .center
//            lb.lineBreakMode = .byCharWrapping
//            lb.numberOfLines = 2
//            let font = UIFont(name: "Arial", size: CGFloat(25))
//            lb.font = font
            
            //let angleLabel = calculateAngle(x1: Int(center.x), y1: Int(center.y), x2: 0, y2: 0)
            
            //let a =  abs(90 - angleLabel)
            //let aa = M_PI * 112.5/180
            //lb.transform = CGAffineTransform(rotationAngle: CGFloat( aa  ))
            
//            self.addSubview(lb)
//            lb.backgroundColor = UIColor.purple
//            
//            print(lb.frame)
            
        }
        
        
        
        
        
        //context?.closePath()
        
        
    }
    
    func calculateAngle(x1:Int,y1:Int,x2:Int,y2:Int) -> Double {
        
        let x = Double( x2 - x1)
        let y = Double(y2 - y1)
        
        let hypotenuse = sqrt(pow(x, 2)+pow(y, 2))
        
        //斜边长度
        let cos = x/hypotenuse
        let radian = acos(cos)
        
        //求出弧度
        var angle = 180/( M_PI/radian )
        
        //用弧度算出角度
        if y<0 {
            angle = -angle
        }else if y==0 && x<0 {
            angle = 180
        }
        
        return angle
    }
    
    
}
