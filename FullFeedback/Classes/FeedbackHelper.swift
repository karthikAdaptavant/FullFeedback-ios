//
//  FeedbackHelper.swift
//  FullFeedback
//
//  Created by Karthik on 11/22/17.
//
import Foundation

open class FeedbackHelper {
    
    public init() {
        
    }
    
    public static func getFeedbackViewController() -> FeedbackViewController? {
        
        guard let bundle = Bundle(identifier: "org.cocoapods.FullFeedback") else {
            print("bundle not found")
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Feedback", bundle: bundle)
        
        guard let feedbackVc = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController else{
            print("Error: Feedback viewcontroller not found")
            return nil
        }
        
        return feedbackVc
    }
}
