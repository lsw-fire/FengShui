//
//  CompassViewController.swift
//  fengshui
//
//  Created by Li Shi Wei on 20/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

import CoreLocation
import CoreMotion
import core

class CompassViewController: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var lbHomeDirection: UILabel!
    @IBOutlet weak var lbAngelText: UILabel!
    @IBOutlet weak var eightTrigramView: EightTrigramTriangelPartView!
    
    @IBOutlet weak var innerView: InnerView!
    var locationManager: CLLocationManager!
    
    let manager = CMMotionManager()
    
    @IBOutlet weak var outterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        
        eightTrigramView.setup()
        
        createOutterView()
        
        createGravityInnerView()
        
        startGyro()
        
        self.view.tintColor = defaultTextColor
        
        lbHomeDirection.textColor = defaultTextColor
        lbAngelText.textColor = defaultTextColor
        
        self.title = "宅"
        
        Button.setStyleFor(button: btnDirection)
        btnHouseDirection.isEnabled = false
        Button.setStyleFor(button: btnHouseDirection)
        
        outterView.backgroundColor = UIColor.clear
        
//        let trigram = ZiBaiGenerator.getHouseDirectionBy(selfTrigramName: "离", doorPositionTrigramName: "震", floorNumber: 18)
//        
//        print(trigram)
    }
    
    var defaultTextColor = UIColor.orange
    
    func startGyro() {
        if manager.isGyroAvailable {
            manager.gyroUpdateInterval = 0.1
            manager.startGyroUpdates()
            
            if manager.isDeviceMotionAvailable {
                manager.deviceMotionUpdateInterval = 0.01
                
                manager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                    
                    if error != nil{
                        self.manager.stopGyroUpdates()
                    }
                    
                    if let gravity = data?.gravity{
                        let x = self.gravityInnerViewCenter.x + CGFloat(gravity.x * 100)
                        let y = self.gravityInnerViewCenter.y + CGFloat(gravity.y * 100)
                        self.gravityInnerView.center = CGPoint(x: x, y: y)
                    }
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func creatInnerViewTarget(frame: CGRect) -> CAShapeLayer{
        
        let width = frame.width
        let height = frame.height
        
        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: frame.origin.x, y: (frame.origin.y + height/2)))
        //        path.addLine(to: CGPoint(x: (frame.origin.x + width), y: (frame.origin.y + height/2)))
        //
        //        path.move(to: CGPoint(x: (frame.origin.x + width/2), y: frame.origin.y))
        //        path.addLine(to: CGPoint(x: (frame.origin.x + width/2), y: (frame.origin.y + height)))
        let center = CGPoint(x: (frame.origin.x + width/2), y: (frame.origin.y + height/2))
        path.addArc(withCenter: center, radius: width/2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        let perLayer = CAShapeLayer()
        perLayer.lineWidth = 2;
        perLayer.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5).cgColor
        perLayer.path = path.cgPath
        
        return perLayer
    }
    
    func createOutterView() {
        //let width = eightTrigramView.frame.width + 20
        let width = outterView.frame.width
        //let width = self.view.frame.width
        //let height = self.view.frame.height
        let resource = ApplicationResource.sharedInstance
        
        let center = CGPoint(x: width/2, y: width/2)
        
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
                
                let num = i - 270 <= 0 ? abs(i - 270) : 360 - abs( i - 270)
                let tickText = String.init(format: "%d", num)
                
                let text = UILabel(frame: CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20))
                text.text = tickText;
                let font = UIFont(name: "Arial", size: CGFloat(8))
                text.font = font;
                
                let perPart = (Double(num) - 22.5)/45
                
                var name = ""
                if perPart < 0 || perPart > 7{
                    name = names[4]
                }else{
                    var index = Int(perPart) + 1 + 4
                    index = index > 7 ? index - 8 : index
                    name = names[index]
                }
                
                let aliasName = trigramNamesMapping[name]
                let fiveElement = defaultTrigramList[aliasName!]!.fiveElement
                let textColor = resource.getColorByFiveElement(fiveElement.rawValue)
                
                text.textColor = textColor
                text.textAlignment = .center;
                let angel = startAngel >= 0 ? -startAngel : abs(startAngel)
                text.transform = CGAffineTransform(rotationAngle: CGFloat(angel + M_PI/2))
                //print(startAngel)
                //text.backgroundColor = UIColor.blue
                //self.view.addSubview(text)
                //eightTrigramView.addSubview(text)
                outterView.addSubview(text)
                
                
            }else{
                perLayer.strokeColor = UIColor.gray.cgColor
                perLayer.lineWidth   = 5;
                
            }
            
            perLayer.path = tickPath.cgPath;
            //self.view.layer.addSublayer(perLayer)
            //eightTrigramView.layer.addSublayer(perLayer)
            outterView.layer.addSublayer(perLayer)
            
        }
        
        innerView.backgroundColor = UIColor.clear
    }
    
    var gravityInnerView : UIView!
    var gravityInnerViewCenter : CGPoint!
    
    func createGravityInnerView() {
        
        let width = innerView.frame.width
        let center = CGPoint(x: width/2, y: width/2)
        gravityInnerViewCenter = center
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.center = center
        view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        view.layer.cornerRadius = view.frame.size.height/2
        view.layer.masksToBounds = true
        gravityInnerView = view
        innerView.addSubview(view)
        innerView.layer.addSublayer(creatInnerViewTarget(frame: view.frame))
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
        
        let val = CGFloat(M_PI - newHeading.magneticHeading * M_PI/180)
        
        let angelText = (newHeading.magneticHeading - 180) >= 0 ? (newHeading.magneticHeading - 180) :  (newHeading.magneticHeading + 180)
        //print(angelText)
        
        let ca = Int(angelText)
        var name = "离"
        
        let perPart = (Double(ca) - 22.5)/45
        if perPart < 0 || perPart > 7{
            name = names[4]
        }else{
            var index = Int(perPart) + 1 + 4
            index = index > 7 ? index - 8 : index
            name = names[index]
        }

        
        let aliasName = trigramNamesMapping[name]
        let positionName = defaultTrigramList[aliasName!]?.positonName
        
        
        let angel = CGAffineTransform(rotationAngle: val)
        eightTrigramView.transform = angel
        outterView.transform = angel
        angelDegree = ca
        lbAngelText.text = positionName! + "-" + Int(angelText).description
    }
    
    let names = ["坎","艮","震","巽","离","坤","兑","乾"]
    
    var isDirectionStopped = false
    var angelDegree : Int?
    
    @IBAction func btnConfirmDirection(_ sender: Any) {
        
        if isDirectionStopped
        {
            startGyro()
            locationManager.startUpdatingHeading()
            
            isDirectionStopped = false
            
            btnDirection.setTitle("定坐向", for: .normal)
            btnHouseDirection.isEnabled = false
            lbHomeDirection.text = "坐向"
        }
        else
        {
            
            var name = "坎"
            var targetName = "离"
            let currentAngel = angelDegree
            //22.5 = 45/2
            if let ca = currentAngel
            {
                let perPart = (Double(ca) - 22.5)/45
                if perPart < 0 || perPart > 7{
                    name = names[0]
                }else{
                    name = names[Int(perPart) + 1]
                }
                
                if perPart < 0 || perPart > 7{
                    targetName = names[4]
                }else{
                    var index = Int(perPart) + 1 + 4
                    index = index > 7 ? index - 8 : index
                    targetName = names[index]
                }
                
                houseTrigramName = name
                
                lbHomeDirection.text = "坐:" + name + " 向:" + targetName
            }
            
            manager.stopGyroUpdates()
            manager.stopDeviceMotionUpdates()
            locationManager.stopUpdatingHeading()
            
            isDirectionStopped = true
            
            btnDirection.setTitle("复位", for: .normal)
            
            btnHouseDirection.isEnabled = true
        }
    }
    
    var houseTrigramName = "坎"
    
    @IBOutlet weak var btnHouseDirection: UIButton!
    
    @IBAction func btnHourseDirectionTap(_ sender: Any) {
        
        let c = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "HouseTrigramViewController") as! HouseTrigramViewController
        
        c.houseTrigramName = houseTrigramName
        
        self.navigationController?.pushViewController(c, animated: true)
        
    }
    @IBAction func biSettingTap(_ sender: Any) {
        
        let controller = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "settingTableViewController") as! SettingTableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
        
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
