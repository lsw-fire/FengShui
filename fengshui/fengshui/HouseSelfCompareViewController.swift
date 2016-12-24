//
//  HouseSelfCompareViewController.swift
//  fengshui
//
//  Created by Li Shi Wei on 24/12/2016.
//  Copyright © 2016 li. All rights reserved.
//

import UIKit
import core

class HouseSelfCompareViewController: UIViewController {
    
    @IBOutlet weak var tvcHouse: TrigramViewContainer!
    @IBOutlet weak var tvcSelf: TrigramViewContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
        let appShared = UIApplication.shared.delegate as! AppDelegate
        
        if let index =  Int(appShared.selfTrigramIndex){
            let selfTrigram = trigramNamesArray[index]
            loadContent(selfTrigramView: tvcSelf,name: selfTrigram,isSelf: true)
        }
        
        if !appShared.houseTrigram.isEmpty {
            tvcHouse.isHidden = false
            loadContent(selfTrigramView: tvcHouse,name: appShared.houseTrigram)
        }else{
            tvcHouse.isHidden = true
        }
        
        self.title = "宅/主卦"
    }
    
    let defaultTrigrams = ["巽","离","坤","震","","兑","艮","坎","乾"]
    
    func loadContent(selfTrigramView: TrigramViewContainer, name:String, isSelf:Bool = false) {
        
        for i in 0..<selfTrigramView.cells.count {
            selfTrigramView.cells[i].trigramName = defaultTrigrams[i]
            
            let d = defaultTrigramList[trigramNamesMapping[name]!]
            if !defaultTrigrams[i].isEmpty {
                let t = defaultTrigramList[trigramNamesMapping[defaultTrigrams[i]]!]
                
                let m = ZiBaiGenerator.getPositionName(from: d!, to: t!)
                
                selfTrigramView.cells[i].baZhaPositionName = m.rawValue
                selfTrigramView.cells[i].trigramDirection = t!.positonName
            }else{
                if isSelf {
                    selfTrigramView.cells[i].baZhaPositionName = "主"
                }else
                {
                    selfTrigramView.cells[i].baZhaPositionName = "宅"
                }
                selfTrigramView.cells[i].trigramName = name
                selfTrigramView.cells[i].trigramDirection = ""
            }
            
        }
        
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
