//
//  FullFeedbackService.swift
//  FullFeedback
//
//  Created by Karthik on 12/10/19.
//

import Foundation

typealias TaskCompletion = ((_ success: Bool) -> Void)

// MARK: Construct DS Task
// FUllFeedback internal shared stated. This will be used inside the framework only
class FullTaskService {
	static let shared = FullTaskService()
	
	var taskParam: TaskParam!
	var taskContent: TaskContent!
	var apiConstants: TaskApiConstants!
	var taskType: TaskType!
	
	private init() {
		fullTaskLogMessage("Initiaiting FullFeedback Service: Internal Shared State")
	}
	
	func assign(param: TaskParam) {
		self.taskParam = param
	}
	func assign(content: TaskContent) {
		self.taskContent = content
	}
	func assign(apiConstants: TaskApiConstants) {
		self.apiConstants = apiConstants
	}
	func assign(taskType: TaskType) {
		self.taskType = taskType
	}
	
	func postFeedback(completion: TaskCompletion?) throws {
		let postable = getPostable(forType: taskType)
		try postable.postFeedback(completion: completion)
	}
	
	private func getPostable(forType type: TaskType) -> FullTaskPostable {
		let postable: FullTaskPostable = (type == .awTask)
			? AwTaskService(param: taskParam, content: taskContent)
			: DsTaskService(param: taskParam, content: taskContent)
		return postable
	}
}

