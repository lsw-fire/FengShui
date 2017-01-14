//
//  Application.swift
//  fengshui
//
//  Created by Li Shi Wei on 14/01/2017.
//  Copyright © 2017 li. All rights reserved.
//

import Foundation
let _SharedInstance = Application()

class Application: NSObject {
    
    public class var sharedInstance : Application {
        return _SharedInstance
    }
    
    let userDefaults = UserDefaults.standard
    
    let isEnable24Mountain = "24Mountain"
    func setEnable24Mountain(value: Bool) {
        userDefaults.set(value, forKey: isEnable24Mountain)
        userDefaults.synchronize()
    }
    
    func getEnable24Mountain() -> Bool {
        return userDefaults.bool(forKey: isEnable24Mountain)
    }
    
}
