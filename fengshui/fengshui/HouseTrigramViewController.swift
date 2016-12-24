//
//  SelfTrigramViewController.swift
//  lunar.calendar
//
//  Created by Li Shi Wei on 18/12/2016.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit
import core

class HouseTrigramViewController: UIViewController {
    
    @IBOutlet weak var selfTrigramView: TrigramViewContainer!
    
    var houseTrigramName = "离"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bi = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action:nil)
        self.navigationItem.backBarButtonItem = bi
        
        loadContent()
        
        self.view.tintColor = UIColor.orange
        
        Button.setStyleFor(button: btnSelfTrigram)
        
        self.title = "八方位置"
        
        let appShared = UIApplication.shared.delegate as! AppDelegate
        appShared.houseTrigram = houseTrigramName
        
    }
    
    let defaultTrigrams = ["巽","离","坤","震","","兑","艮","坎","乾"]
    
    func loadContent() {
        
        for i in 0..<selfTrigramView.cells.count {
            selfTrigramView.cells[i].trigramName = defaultTrigrams[i]
            
            let d = defaultTrigramList[trigramNamesMapping[houseTrigramName]!]
            if !defaultTrigrams[i].isEmpty {
                let t = defaultTrigramList[trigramNamesMapping[defaultTrigrams[i]]!]
                
                let m = ZiBaiGenerator.getPositionName(from: d!, to: t!)
                
                selfTrigramView.cells[i].baZhaPositionName = m.rawValue
                selfTrigramView.cells[i].trigramDirection = t!.positonName
            }else{
                selfTrigramView.cells[i].baZhaPositionName = "宅"
                selfTrigramView.cells[i].trigramName = houseTrigramName
                selfTrigramView.cells[i].trigramDirection = ""
            }
            
        }
        
    }
    
    @IBAction func btnSelfTrigramTap(_ sender: Any) {
        
        let urlStr = "OpenSelfTrigramSelect://param?from=fengshui"
        
        let customUrl = URL(string: urlStr)
        
        if UIApplication.shared.canOpenURL(customUrl!) {
            
            UIApplication.shared.open(customUrl!, options: [:], completionHandler: {
                (success) in
                print("open url")
            })
        }else{
            UIApplication.shared.open(URL(string:"itms-apps://itunes.apple.com/app/id1187716151")!, options: [:], completionHandler:{ (success) in print("open url") })
        }

    }
    @IBOutlet weak var btnSelfTrigram: UIButton!
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
