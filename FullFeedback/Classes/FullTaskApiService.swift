//
//  DSTaskNetworkManager.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DSFeedbackParams {
    
    let dsParamHelper: TaskParam
    let historyComments: [[String: Any]]
    
    var documents: [String: Any]?
    var relationShips: [String: Any]?
    var comments: String
}

enum AWFeedbackParamsKey: String {
    
    case dept = "dept"
    case deptId = "dept_id"
    case taskType = "task_type"
    case brandId = "brand_id"
    case tags = "tags"
    
    var value: String {
        return self.rawValue
    }
}

struct TaskApi {
    
    // Task Construction
	static func constructDSTaskRequest(_ dsParams: DSFeedbackParams) throws -> URLRequest {
        
		let apiConstants: TaskApiConstants = FullTaskService.shared.apiConstants
		
        guard let apiKey = apiConstants.apiKey else {
            throw DSTaskError.invalidParam("ApiKey Not Found")
        }
        let queryParams: [String: Any] = ["apikey": apiKey]
        
        var params: [String: Any] = ["departmentID": dsParams.dsParamHelper.departmentId,
									 "department": dsParams.dsParamHelper.department,
									 "type": dsParams.dsParamHelper.type,
									 "comments": dsParams.comments]
        
        params.updateValue(dsParams.historyComments, forKey: "history")
        params.updateValue(dsParams.dsParamHelper.source, forKey: "source")
        
        if let brandId = dsParams.dsParamHelper.brandId {
            params.updateValue(brandId, forKey: "brandID")
        }
        
        if let searchRelationShip = dsParams.relationShips {
            params.updateValue(searchRelationShip, forKey: "searchRelationships")
        }
        
        if let uploadDocuments = dsParams.documents {
            params.updateValue(uploadDocuments, forKey: "uploadedDocuments")
        }
        
		guard let url = URL(string: apiConstants.getDsTaskUrl()) else {
            throw DSTaskError.invalidURL("Failed In URL Conversion")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        urlRequest.setValue(dsParams.dsParamHelper.accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    // MARK: Network Request
	static func makeDSTaskRequest(_ request: URLRequest, _ completion: TaskCompletion?) {
        
        Alamofire.request(request).responseData { (response) in
            switch response.result {
            case .success(_):
                completion?(true)
            case .failure(let error):
                completion?(false)
            }
        }
    }
}

// MARK: AW Task Handler
extension TaskApi {
    
	static func makeAWTaskRequest(_ feedback: String, _ dsParams: TaskParam, _ completion: TaskCompletion?) {
        		 
		let urlStr: String = FullTaskService.shared.apiConstants.getAwTaskUrl()
	        
        Alamofire.upload(multipartFormData: { formdata in
            
            formdata.append(dsParams.department.toData(), withName: AWFeedbackParamsKey.dept.value)
            formdata.append(dsParams.departmentId.toData(), withName: AWFeedbackParamsKey.deptId.value)
            formdata.append(dsParams.type.toData(), withName: AWFeedbackParamsKey.taskType.value)
            formdata.append(dsParams.source.toData(), withName: AWFeedbackParamsKey.tags.value)
            
            if let brandId = dsParams.brandId {
                formdata.append(dsParams.brandId!.toData(), withName: AWFeedbackParamsKey.brandId.value)
            }
            
            formdata.append(feedback.data(using: String.Encoding.utf8)!, withName: "card_title")
            
        }, usingThreshold: UInt64.init(), to: urlStr, method: .post, headers: ["Authorization": "Bearer \(dsParams.accessToken)"], encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
				
			case .failure(let encodingError):
				completion?(false)
                
            case .success(let upload, _, _):
                
                upload.responseJSON(completionHandler: { (response) in
					fullTaskLogMessage("Task Response: \(JSON(response.result.value))")
                    
                    if let resp = response.response, (resp.statusCode == 401) {
                        completion?(false)
                        return
                    }
                    guard response.result.isSuccess else {
                        completion?(false)
                        return
                    }
                    completion?(true)
                })
            }
        })
    }
 }
