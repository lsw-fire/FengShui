//
//  CompassViewController.swift
//  fengshui
//
//  Created by Li Shi Wei on 20/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

import CoreLocation

class CompassViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var eightTrigramView: EightTrigramTriangelPartView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        eightTrigramView.setup()
        
        //let width = eightTrigramView.frame.width + 20
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let center = CGPoint(x: width/2, y: height/2)
        
        let perAngle = 2 * M_PI / 360;
        //我们需要计算出每段弧线的起始角度和结束角度
        //这里我们从- M_PI 开始，我们需要理解与明白的是我们画的弧线与内侧弧线是同一个圆心
        for i in 0...359 {
            
            let startAngel = (-M_PI + perAngle * Double(i))
            let endAngel   = startAngel + perAngle/10
            
            let tickPath = UIBezierPath.init(arcCenter: center, radius: (width-30)/2, startAngle:CGFloat(startAngel), endAngle: CGFloat(endAngel), clockwise: true)
           
            let perLayer = CAShapeLayer()
            
            if (i % 10 == 0) {
                
                perLayer.strokeColor = UIColor.black.cgColor
                perLayer.lineWidth   = 10;
                
                let point = self.calculateTextPositonWithArcCenter(center: center, angel: CGFloat(startAngel), r: (width-15)/2)
                
                let tickText = String.init(format: "%d", i)
                
                let text = UILabel(frame: CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20))
                text.text          = tickText;
                let font = UIFont(name: "Arial", size: CGFloat(8))
                text.font = font;
                text.textColor = UIColor.brown
                text.textAlignment = .center;
                let angel = startAngel >= 0 ? -startAngel : abs(startAngel)
                text.transform = CGAffineTransform(rotationAngle: CGFloat(angel + M_PI/2))
                print(startAngel)
                //text.backgroundColor = UIColor.blue
                self.view.addSubview(text)
                //eightTrigramView.addSubview(text)
                
                
            }else{
                perLayer.strokeColor = UIColor.gray.cgColor
                perLayer.lineWidth   = 5;
                
            }
            
            perLayer.path = tickPath.cgPath;
            self.view.layer.addSublayer(perLayer)
            //eightTrigramView.layer.addSublayer(perLayer)
            
            
            
        }
    }
    
    func calculateTextPositonWithArcCenter(center: CGPoint, angel: CGFloat, r: CGFloat) -> CGPoint {
        let x = r * CGFloat(cosf(Float(angel)))
        let y = r * CGFloat(sinf(Float(angel)))
        
        return CGPoint(x: center.x + x, y: center.y - y)
    }

    
    var angel:Float = 0
    func transformAction() {
        angel = angel + 0.01
        if angel > 6.28 //mp*2 360
        {
            angel = 0
        }
        
        eightTrigramView.transform = CGAffineTransform(rotationAngle: CGFloat( angel))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        let val = CGFloat(newHeading.magneticHeading * M_PI/180)
        print(val)
        eightTrigramView.transform = CGAffineTransform(rotationAngle: val)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
