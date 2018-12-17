//
//  DSTaskParams.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation
import Alamofire

// MARK: Pod Consumer should give the params
public struct DSParamHelper {
    
    let department: String
    let departmentId: String
    let brandId: String
    var accountIds: [String]?
    
    let type: String
    let source: String
    
    let accessToken: String
    
    //UserInfo
    let emailId: String
    var userName: String?
    
    var documents: [String]?
    
    public init(department: String, departmentId: String, brandId: String, type: String, source: String, accessToken: String, emailId: String) {
        
        self.department = department
        self.departmentId = departmentId
        
        self.brandId = brandId
        
        self.type = type
        self.source = source
        
        self.accessToken = accessToken
        self.emailId = emailId
    }
    
    public init(department: String, departmentId: String, brandId: String, type: String, source: String, accessToken: String, emailId: String, accountIds: [String]?, userName: String?, documents: [String]?) {
        
        self.init(department: department, departmentId: departmentId, brandId: brandId, type: type, source: source, accessToken: accessToken, emailId: emailId)
        
        // Optionals
        self.accountIds = accountIds
        self.userName = userName
        self.documents = documents
    }
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
    
    func postFeedback(_ completion: DSTaskCompletion?) throws {
        
        try validateDSParams()
        
        let historyComments = try constructHistoryComments()
        
        let dsFeedbackParams = DSFeedbackParams(dsParamHelper: dsParamHelper, historyComments: historyComments, documents: constructUploadDocuments(), relationShips: constructSearchRelationShips(), comments: feedback)
        
        let urlRequest = try dsTaskApiHandler.constructTaskRequest(dsFeedbackParams)
        
        dsTaskApiHandler.makeTaskRequest(urlRequest, completion)
    }
    
    private func validateDSParams() throws {
        
        try validate(param: dsParamHelper.department, of: .department)
        try validate(param: dsParamHelper.brandId, of: .brandId)
        
        try validate(param: dsParamHelper.source, of: .source)
        try validate(param: dsParamHelper.type, of: .type)
        
        try validate(param: dsParamHelper.accessToken, of: .accessToken)
    }
}

// MARK: JSON Constructor
extension DSFeedbackApiService {
    
    private func constructHistoryComments() throws -> [[String: Any]] {
        
        try validate(param: dsParamHelper.emailId, of: .emailId)
        
        var userInfo = "<\(dsParamHelper.emailId)>"
        
        if let name = dsParamHelper.userName {
            userInfo = "<\(name)>" + userInfo
        }
        
        try validate(param: dsParamHelper.departmentId, of: .departmentId)
        
        let historyComments: [[String: Any]] = [["historyComments": "\(feedback) \n\n \(feedbackSignature ?? "")   ", "ownerName": "\(userInfo)", "type": "inboundemail", "departmentID": dsParamHelper.departmentId]]
        return historyComments
    }
    
    private func constructUploadDocuments() -> [String: Any]? {
        
        guard let documents = dsParamHelper.documents else {
            return nil
        }
        
        let uploadDocuments: [String: Any]? = ["uploadedDocuments": dsParamHelper.documents]
        return uploadDocuments
    }
    
    private func constructSearchRelationShips() -> [String: Any]? {
        
        guard let accountIds = dsParamHelper.accountIds else {
            return nil
        }
        
        let searchRelationShip: [String: Any] = ["accountsID": accountIds]
        return searchRelationShip
    }
}

// MARK: Validtor
extension DSFeedbackApiService {
    
    private func validate(param: String, of type: ErrorValidatorType) throws {
        
        guard !param.isEmpty else {
            throw DSTaskError.invalidParam("Invalid \(type.rawValue)")
        }
    }
}
