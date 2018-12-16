//
//  DSTaskParams.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation

// MARK: Consumer should give the params
struct DSParamHelper {
    
    let department: String
    let departmentId: String
    let brandId: String
    var accountIds: [String]?
    
    let type: String
    let source: String

    //UserInfo
    let emailId: String
    var userName: String?
    
    var documents: [String]?
}

typealias DSTaskCompletion = ((_ success: Bool) -> Void)

// MARK: Construct DS Task
class DSFeedbackApiService {
    
    private let feedback: String
    private let dsParamHelper: DSParamHelper
    private var feedbackSignature: String?
    private let dsTaskApiHandler = DSTaskApiHandler()
    
    init(_ dsParams: DSParamHelper,  _ feedback: String, _ feedbackSignature: String?) {
        
        self.feedback = feedback
        self.dsParamHelper = dsParams
        self.feedbackSignature = feedbackSignature
    }
    
    private func constructHistoryComments() -> [[String: Any]] {
        
        var userInfo = "<\(dsParamHelper.emailId)>"
        
        if let name = dsParamHelper.userName {
            userInfo = "<\(name)>" + userInfo
        }
        
        let historyComments: [[String: Any]] = [["historyComments": "\(feedback) \n\n \(feedbackSignature ?? "")   ", "ownerName": "\(userInfo)", "type": "inboundemail", "departmentID": dsParamHelper.departmentId]]
        return historyComments
    }
    
    private func constructSearchRelationShips() -> [String: Any]? {
        
        guard let accountIds = dsParamHelper.accountIds else {
            return nil
        }
        
        let searchRelationShip: [String: Any] = ["accountsID": accountIds]
        return searchRelationShip
    }
    
    private func uploadDocuments() -> [String: Any]? {
        
        guard let documents = dsParamHelper.documents else {
            return nil
        }
        
        let uploadDocuments: [String: Any]? = ["uploadedDocuments": dsParamHelper.documents]
        return uploadDocuments
    }
    
    func postFeedback(_ completion: DSTaskCompletion?) throws {
        
        let dsFeedbackParams = DSFeedbackParams(dsParamHelper: dsParamHelper, historyComments: constructHistoryComments(), documents: uploadDocuments(), relationShips: constructSearchRelationShips())
        
        let urlRequest = try dsTaskApiHandler.constructTaskRequest(dsFeedbackParams)
    }

}
