//
//  TestViewController.swift
//  fengshui
//
//  Created by Li Shi Wei on 19/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var lbLeftTip: UILabel!
    @IBOutlet weak var view1: TriangelView!
    
    @IBOutlet weak var view0: TriangelView!
  
    @IBOutlet weak var lbName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let width = Int( view1.frame.size.width)
        let height = Int( view1.frame.size.height)
        
        
//        let angel =  view1.calculateAngle(x1: width/2, y1: 0, x2: 0, y2: height)
//        print(angel)
//        lbName.layer.borderWidth = 1
//        lbName.layer.borderColor = UIColor.orange.cgColor
//        
//        let a =  abs(90 - angel) 
//        let aa = M_PI * a/180
//        lbName.transform = CGAffineTransform(rotationAngle: CGFloat( aa  ))
        view0.widthForShow = view1.frame.width
        view1.widthForShow = view1.frame.width
        view1.backgroundColor = UIColor.clear
        //view0.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        view0.backgroundColor = UIColor.clear
        //let p = view0.layer.position
        view0.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI/4  ))
        
        lbLeftTip.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI * 2 - M_PI/8  ))
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
