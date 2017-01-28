//
//  ViewController.swift
//  fengshui
//
//  Created by Li Shi Wei on 15/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate  {

    @IBOutlet weak var lbDegree: UILabel!
    @IBOutlet weak var imgComapss: UIImageView!
    var locationManager: CLLocationManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        
//        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.transformAction), userInfo: nil, repeats: true)
        
    }
    var angel:Float = 0
    func transformAction() {
        angel = angel + 0.01
        if angel > 6.28 //mp*2 360
        {
            angel = 0
        }
        
        imgComapss.transform = CGAffineTransform(rotationAngle: CGFloat( angel))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //print(newHeading.magneticHeading)
//        let degree:Double = 45
//        let angel = Double( degree * M_PI)
        let val = CGFloat(M_PI - newHeading.magneticHeading * M_PI/180)
        print(val)
        lbDegree.text = val.description
        imgComapss.transform = CGAffineTransform(rotationAngle: val)
    }
}

