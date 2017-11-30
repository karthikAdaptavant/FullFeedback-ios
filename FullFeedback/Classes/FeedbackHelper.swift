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
    
    public init() {
        
    }
    
    static var loopKey = String()
    
    public static func getFeedbackViewController(loopToDoKey key: String) -> FeedbackViewController? {
        
        guard let bundle = Bundle(identifier: "org.cocoapods.FullFeedback") else {
            print("bundle not found")
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Feedback", bundle: bundle)
        
        guard let feedbackVc = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController else{
            print("Error: Feedback viewcontroller not found")
            return nil
        }
        
        loopKey = key
        feedbackVc.loopToDoKey = key
        
        return feedbackVc
    }
    
    public static func constructLoopToDoURL(feedbackText text: String) {
        
        guard let url = URL(string: "http://my.loopto.do/forms/process/?json=true&t=\(Int64(Date().timeIntervalSince1970)*Int64(1000))") else {
            return
        }
    
        let params: [String: String] = getFeedbackDictionary(feedbackText: text)
        let headers = [ "Content-Type": "application/x-www-form-urlencoded" ]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
        if let responseData = data {
            do {
                let jsonSerialized = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            }  catch let error as NSError {
                print(error.localizedDescription)
            }
        } else if let error = error {
            print(error.localizedDescription)
        }
        }
        task.resume()
    }
    
   public static func getFeedbackDictionary(feedbackText text: String) -> [String: String] {
    return ["loopKey": loopKey, "text": text]
    }
    
}

