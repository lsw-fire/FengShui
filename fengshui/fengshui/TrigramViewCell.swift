//
//  TrigramViewCell.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 18/12/2016.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import core

class TrigramViewCell: UIView {
    
    @IBOutlet weak var btnBaZhaiPositionName: UIButton!
    
    @IBOutlet weak var btnTrigramName: UIButton!
    
    @IBOutlet weak var btnTrigramDirection: UIButton!
    
    var trigramName:String = "" {
        didSet{
            if !trigramName.isEmpty {
                btnTrigramName.setTitle(trigramName, for: .normal)
                
                if trigramName != "宅" {
                    
                    let aliasName = trigramNamesMapping[trigramName]
                    let fiveElement = defaultTrigramList[aliasName!]?.fiveElement
                    let tintColor = ApplicationResource.sharedInstance.getColorByFiveElement((fiveElement?.rawValue)!)
                    btnTrigramName.setTitleColor(tintColor, for: .normal)
                    btnTrigramDirection.setTitleColor(tintColor, for: .normal)
                    btnBaZhaiPositionName.setTitleColor(tintColor, for: .normal)
                    
                    self.layer.borderColor = tintColor.cgColor
                }
                
            }
        }
    }
    
    var trigramDirection:String = "" {
        didSet{
            //if !trigramDirection.isEmpty {
            btnTrigramDirection.setTitle(trigramDirection, for: .normal)
                      //}
        }
    }
    
    var baZhaPositionName:String = "" {
        didSet{
            //if !baZhaPositionName.isEmpty{
            btnBaZhaiPositionName.setTitle(baZhaPositionName, for: .normal)
            btnBaZhaiPositionName.titleLabel?.adjustsFontSizeToFitWidth = true
            //}
            Button.setStyleFor(button: btnBaZhaiPositionName)
            let enumPositon = EnumBaZhaiPositon(rawValue: baZhaPositionName)
            if let p = enumPositon
            {
                let pn =  EnumBaZhaiPositon.getIsPositiveAndNineStar(baZhai: p)
                //let nineStar = pn.1
                //let isPositiveAndFE = EnumNineStar.getFiveElement(nineStar: nineStar)
                if  pn.0 {
                    btnBaZhaiPositionName.backgroundColor = UIColor.orange
                    btnBaZhaiPositionName.setTitleColor(UIColor.white, for: .normal)
                }else
                {
                    btnBaZhaiPositionName.backgroundColor = UIColor.lightGray
                    btnBaZhaiPositionName.setTitleColor(UIColor.white, for: .normal)
                }
            }

        }
    }
}
