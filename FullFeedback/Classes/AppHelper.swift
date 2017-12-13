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
    
    public func postFeedback(withParam param: [String: Any], completion: ((_ success: Bool) -> ())?) {
        
        guard let url  = URL(string: "http://my.loopto.do") else {
            completion?(false)
            return
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/forms/process"))
        let queryParameters:[String: Any] = ["json": true, "t": Int64(Date().timeIntervalSince1970 * 1000)]
        
        urlRequest = try! URLEncoding.queryString.encode(urlRequest, with: queryParameters)
        urlRequest = try! URLEncoding.default.encode(urlRequest, with: param)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        _ = Alamofire.request(urlRequest).responseData { response in
            
            switch response.result {
                
            case .failure(_):
                completion?(false)
            case .success(_):
                completion?(true)
            }
        }
    }
    
    open func getParam(forLoopKey loopkey: String, text: String, cardTitle: String,  userInfo: [String: Any]?, appInfo: [String: Any], deviceInfo: [String: Any], userName: String, userEmail: String, selectedIndexTag: String) -> [String: Any] {
        
        var constructedStr: String = "\(text)"
        
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
        
        let param: [String: Any] =  ["user_tag": "", "tag": selectedIndexTag, "loopKey": loopkey, "user_name": userName ,"user_email": userEmail, "card_title": cardTitle,"card_desc": constructedStr]
        
        return param
    }
}
