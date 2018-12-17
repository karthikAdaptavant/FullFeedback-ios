//
//  AppHelper.swift
//  Pods
//
//  Created by Karthik on 12/4/17.
//
//

import Foundation
import UIKit
import Alamofire

open class FeedbackHelper {
    
    public init() { }
    
    open func constructFeedbackSignature(userInfo: [String: Any]?, appInfo: [String: Any], deviceInfo: [String: Any]) -> String {
        
        var constructedStr: String = ""
        
        constructedStr += "<br><br>------------- Device Info -------------"
        
        for (key, value) in deviceInfo {
            constructedStr += "<br> \(key): \(value)"
        }
        
        constructedStr += "<br><br>------------- Application Info -------------"
        
        if !appInfo.isEmpty {
            
            for (key, value) in appInfo {
                constructedStr += "<br> \(key): \(value)"
            }
        }
        
        if let userInfoDict = userInfo, !userInfoDict.isEmpty {
            
            constructedStr += "<br><br>------------- User Info -------------"
            
            for (key, value) in userInfoDict {
                constructedStr += "<br> \(key): \(value)"
            }
        }
        
        return constructedStr
    }
}
