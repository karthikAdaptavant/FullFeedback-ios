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

class DSTaskApiHandler {
    
    // Task Construction
    internal func constructTaskRequest(_ dsParams: DSFeedbackParams) throws -> URLRequest {
        
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
    internal func makeTaskRequest(_ request: URLRequest, _ completion: DSTaskCompletion?) {
        
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
