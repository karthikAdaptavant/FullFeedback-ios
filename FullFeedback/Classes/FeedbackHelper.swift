//
//  FeedbackHelper.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//
import Foundation
import UIKit
import Alamofire

open class FeedbackHelper {
    
    public init() { }
    
    open func getFeedbackViewController(loopToDoKey key: String) -> FeedbackViewController? {
        
        guard let bundle = Bundle(identifier: "org.cocoapods.FullFeedback") else {
            print("bundle not found")
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Feedback", bundle: bundle)
        
        guard let feedbackVc = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController else{
            print("Error: Feedback viewcontroller not found")
            return nil
        }
        
        feedbackVc.loopToDoKey = key
        
        return feedbackVc
    }
    
    public func postFeedback(withParam param: [String: Any], completion: ((_ success: Bool) -> ())?) {
        
        let url = try! "http://my.loopto.do".asURL()
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
    
    open func getParam(forLoopKey loopkey: String, text: String, params: [String: Any]) -> [String: Any] {
        
        var constructedStr: String = "\(text)"
        
        if let appInfo = params["ApplicationInfo"] as? [String: Any] {
            
            if let login = appInfo["login"] as? String {
                constructedStr += "<br><br>------------- User Info -------------<br>User email: \(login)"
            }
            
            if let version = appInfo["version"]  as? Int {
                constructedStr += "<br><br>------------- Application Info -------------<br>Application version: \(version)"
            }
        }
        
        if let deviceInfo = params["DeviceInfo"] as? [String: Any] {
            
            if let name = deviceInfo["DeviceName"] as? String {
                constructedStr += "<br><br>------------- Device Info -------------<br>Device Name: \(name)"
            }
            
            if let type = deviceInfo["DeviceType"] as? String {
                constructedStr += "<br>Device Model: \(type)"
            }
            
            if let osVersion = deviceInfo["DeviceOsVersion"] {
                constructedStr += "<br>DeviceOs Version: \(osVersion)"
            }
            
        }
        
        let param: [String: Any] =  ["user_tag": "", "tag": "feedBack", "loopKey": loopkey, "user_email": "", "card_title": "IOS FullFeedback","card_desc": constructedStr]
        
        return param
    }
}
