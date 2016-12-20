//
//  EightTrigramTriangelPartView.swift
//  fengshui
//
//  Created by Li Shi Wei on 20/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

 class EightTrigramTriangelPartView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }

    func setup() {
        
        //var verticalArrayView = Array<UIStackView>()
        var cellWidth : CGFloat!
        
        for i in 1...8{
            
            let cell = loadViewFromNib()
            if cellWidth == nil {
                cellWidth = self.frame.width
            }
            cell.vDrawTriangel.widthForShow = cellWidth
           
            if i == 7 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI - M_PI/4  ))
            }
            if i == 8 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI + M_PI/4  ))
            }
            if i == 2 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI/4  ))
            }
            if i == 3 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI/2  ))
            }
            
            if i == 4 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( -M_PI/4  ))
            }
            if i == 5 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( -M_PI/2  ))
            }
            if i == 6 {
                cell.vDrawTriangel.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI  ))
            }
            
            
            cell.backgroundColor = UIColor.clear
            
            cell.vDrawTriangel.backgroundColor = UIColor.clear
            self.addSubview(cell)
            
            cell.translatesAutoresizingMaskIntoConstraints = false
            let hor = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sv]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": cell])
            let vl = NSLayoutConstraint.constraints(withVisualFormat: "V:|[sv]|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["sv": cell])
            self.addConstraints(hor)
            self.addConstraints(vl)
            
        }
        
        self.backgroundColor = UIColor.yellow
    
//        let svvertical = UIStackView(arrangedSubviews: verticalArrayView)
//        

        
    }
    
    func loadViewFromNib() -> EightTrigramView{
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EightTrigramView", bundle: bundle)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! EightTrigramView
        
        return cell
    }

}
