//
//  DSTaskNetworkManager.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation
import Alamofire

struct DSFeedbackParams {
    
    let dsParamHelper: DSParamHelper
    let historyComments: [[String: Any]]
    
    var documents: [String: Any]?
    var relationShips: [String: Any]?
    var comments: String
}

enum AWFeedbackParamsKey: String {
    
    case dept = "dept"
    case deptId = "deptId"
    case taskType = "task_type"
    case brandId = "brand_id"
    case tags = "tags"
}

class DSTaskApiHandler {
    
    // Task Construction
    internal func constructDSTaskRequest(_ dsParams: DSFeedbackParams) throws -> URLRequest {
        
        let queryParams: [String: Any] = ["apikey": Constants.apiKey]
        
        var params: [String: Any] = ["departmentID": dsParams.dsParamHelper.departmentId, "department": dsParams.dsParamHelper.department, "type": dsParams.dsParamHelper.type, "comments": dsParams.comments, "brandID": dsParams.dsParamHelper.brandId]
        
        params.updateValue(dsParams.historyComments, forKey: "history")
        params.updateValue(dsParams.dsParamHelper.source, forKey: "source")
        
        if let searchRelationShip = dsParams.relationShips {
            params.updateValue(searchRelationShip, forKey: "searchRelationships")
        }
        
        if let uploadDocuments = dsParams.documents {
            params.updateValue(uploadDocuments, forKey: "uploadedDocuments")
        }
        
        guard let url  = URL(string: Constants.urlStr) else {
            throw DSTaskError.invalidURL("Failed In URL Conversion")
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/createTask"))
        
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        
        urlRequest.setValue(dsParams.dsParamHelper.accessToken, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    // MARK: Network Request
    internal func makeDSTaskRequest(_ request: URLRequest, _ completion: DSTaskCompletion?) {
        
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
extension DSTaskApiHandler {
    
    internal func makeAWTaskRequest(_ feedback: String, _ dsParams: DSParamHelper, _ completion: DSTaskCompletion?) {
        
        let urlStr: String = Constants.awUrlStr + "/api/v1/task"
        
        Alamofire.upload(multipartFormData: { formdata in
            
            formdata.append(dsParams.department.toData(), withName: AWFeedbackParamsKey.dept.rawValue)
            formdata.append(dsParams.departmentId.toData(), withName: AWFeedbackParamsKey.deptId.rawValue)
            formdata.append(dsParams.type.toData(), withName: AWFeedbackParamsKey.taskType.rawValue)
            formdata.append(dsParams.brandId.toData(), withName: AWFeedbackParamsKey.brandId.rawValue)
            formdata.append(dsParams.source.toData(), withName: AWFeedbackParamsKey.tags.rawValue)
            
            formdata.append(feedback.toData(), withName: "card_title")
            
        }, usingThreshold: UInt64.init(), to: urlStr, method: .post, headers: ["Authorization": "Bearer \(dsParams.accessToken)"], encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    if let resp = response.response, (resp.statusCode == 400) {
                        completion?(false)
                        return
                    }
                    
                    guard response.result.isSuccess else {
                        completion?(false)
                        return
                    }
                    completion?(true)
                })
                
            case .failure(let encodingError):
                completion?(false)
            }
        })
    }
 }
