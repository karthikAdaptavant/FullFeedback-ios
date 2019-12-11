//
//  DsTaskService.swift
//  FullFeedback
//
//  Created by Karthik on 12/10/19.
//

import Foundation

struct DsTaskService: FullTaskPostable {
	
	var param: TaskParam
	var content: TaskContent
	
	func postFeedback(completion: TaskCompletion?) throws {
		
		try validateParams()
		let historyComments = try constructHistoryComments()
		
		let dsFeedbackParams = DSFeedbackParams(dsParamHelper: param,
												historyComments: historyComments,
												documents: constructUploadDocuments(),
												relationShips: constructSearchRelationShips(),
												comments: content.feedbackContent)
		
		let urlRequest = try TaskApi.constructDSTaskRequest(dsFeedbackParams)
		TaskApi.makeDSTaskRequest(urlRequest, completion)
	}
	
	private func constructHistoryComments() throws -> [[String: Any]] {
		
		try validate(param: param.emailId, of: .emailId)
		
		var userInfo = "<\(param.emailId)>"
		if let name = param.userName {
			userInfo = "<\(name)>" + userInfo
		}
		
		try validate(param: param.departmentId, of: .departmentId)
		
		let historyComments: [[String: Any]] = [["historyComments": "\(content.feedbackContent) \n\n \(content.feedbackSignature ?? "")   ",
			"ownerName": "\(userInfo)",
			"type": "inboundemail",
			"departmentID": param.departmentId]]
		return historyComments
	}
	
	private func constructUploadDocuments() -> [String: Any]? {
		
		guard let documents = param.documents else { return nil }
		let uploadDocuments: [String: Any]? = ["uploadedDocuments": param.documents]
		return uploadDocuments
	}
	
	private func constructSearchRelationShips() -> [String: Any]? {
		
		if let accountIds = param.accountIds, let first = accountIds.first {
			let searchRelationShip: [String: Any] = ["accountsID": first]
			return searchRelationShip
		}
		
		if let accountId = param.setmoreAccountId {
			let searchRelationShip: [String: Any] = ["accountsID": accountId]
			return searchRelationShip
		}
		return nil
	}
}
