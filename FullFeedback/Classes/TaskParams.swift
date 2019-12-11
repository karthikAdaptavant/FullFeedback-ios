//
//  DSTaskParams.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation
import Alamofire

// MARK: Pod Consumer should give the params
public struct TaskParam {
    
    let department: String
    let departmentId: String
    
    let type: String     // or TaskType in AW
    let source: String   // or Tags in AW
    
    let accessToken: String
    
    let emailId: String
    var userName: String?
    
    var brandId: String?  // Need as optional for Setmore
    var documents: [String]?
    
    var accountIds: [String]?       // for Yoco
    var setmoreAccountId: String?   // for setmore
	
	var taskSignature: String? = nil
    
    // For AW
	public init(department: String, departmentId: String, type: String, source: String, accessToken: String, emailId: String,  brandId: String?, signature: String? = nil) {
        
        self.department = department
        self.departmentId = departmentId
        
        self.type = type        // or TaskType in AW
        self.source = source    // or Tags in AW
        
        self.accessToken = accessToken
        self.emailId = emailId
        self.brandId = brandId
		self.taskSignature = signature
    }
    
    // Convinence For DS Task
    public init(department: String,
				departmentId: String,
				type: String,
				source: String,
				accessToken: String,
				emailId: String,
				brandId: String?,
				signature: String? = nil,
				accountIds: [String]?, userName: String?, documents: [String]?, setmoreAccountId: String?) {
        
		self.init(department: department, departmentId: departmentId, type: type, source: source, accessToken: accessToken, emailId: emailId, brandId: brandId, signature: signature)
        
        // Optionals
        self.brandId = brandId
        self.accountIds = accountIds
        self.userName = userName
        self.documents = documents
        self.setmoreAccountId = setmoreAccountId
    }
}

public struct TaskContent {
	
	let feedbackContent: String
	var feedbackSignature: String? = nil
}

