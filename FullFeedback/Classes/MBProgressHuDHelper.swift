 //
 //  MBProgressHUDHelper.swift
 //  FullFeedback_Example
 //
 //  Created by user on 02/12/17.
 //  Copyright © 2017 CocoaPods. All rights reserved.
 //
 
 import Foundation
 import UIKit
 import MBProgressHUD
 
 extension UIViewController {
    
    public func getAlertHUD(srcView: UIView) -> MBProgressHUD {
        
        let hud = MBProgressHUD(view: srcView)
        
        //Force Unwrapping - assuming hud will not be nil
        srcView.addSubview(hud)
        hud.color = UIColor(red: 53, green: 63, blue: 77, alpha: 1)
        hud.bezelView.backgroundColor = .black
        hud.contentColor = .white
        hud.label.textColor = .white
        return hud
    }
    
 }
 

 
 
