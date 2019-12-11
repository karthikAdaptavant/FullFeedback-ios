//
//  AwTaskService.swift
//  FullFeedback
//
//  Created by Karthik on 12/10/19.
//

import Foundation


struct AwTaskService: FullTaskPostable {
	
	var param: TaskParam
	var content: TaskContent
	
	func postFeedback(completion: TaskCompletion?) throws {
		
		try validateParams()
		try validate(param: param.departmentId, of: .departmentId)
		try validate(param: param.emailId, of: .emailId)
		
		var comment = "\(content.feedbackContent)"
		if let feedbackInfo = content.feedbackSignature {
			comment += " \(feedbackInfo)"
		}
		TaskApi.makeAWTaskRequest(comment, param, completion)
	}
}
