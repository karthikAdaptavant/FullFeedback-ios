//
//  DSTaskNetworkManager.swift
//  FullFeedback
//
//  Created by Sathish on 14/12/18.
//

import Foundation
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
        let queryParams: [String: String] = ["apikey": apiKey]
        
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
        
		guard var urlComponent = URLComponents(string: apiConstants.getDsTaskUrl()) else {
            throw DSTaskError.invalidURL("Failed In URL Conversion")
        }

        var queryItems: [URLQueryItem] = []
        for (key, value) in queryParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {
            throw DSTaskError.invalidURL("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

//        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
//        urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        urlRequest.setValue(dsParams.dsParamHelper.accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    // MARK: Network Request
	static func makeDSTaskRequest(_ request: URLRequest, _ completion: TaskCompletion?) {

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let hasValidData = (data != nil && error == nil)
            guard hasValidData,
                  let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion?(false)
                return
            }
            completion?(true)
        }.resume()
    }
}

// MARK: AW Task Handler
extension TaskApi {
    
	static func makeAWTaskRequest(_ feedback: String, _ dsParams: TaskParam, _ completion: TaskCompletion?) {

        func createFormDataBody(formDataParam: [String: Data], boundary: String) -> Data {
            var body = Data()
            let boundaryPrefix = "\r\n--\(boundary)\r\n"
            for(key, value) in formDataParam {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(value)
            }
            body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
            return body
        }

		let urlStr: String = FullTaskService.shared.apiConstants.getAwTaskUrl()
        guard !urlStr.isEmpty, let url = URL(string: urlStr) else {
            completion?(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data;boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(dsParams.accessToken)", forHTTPHeaderField: "Authorization")

        var formDataParams: [String: Data] = [AWFeedbackParamsKey.dept.value: dsParams.department.toData(),
                                              AWFeedbackParamsKey.deptId.value: dsParams.departmentId.toData(),
                                              AWFeedbackParamsKey.taskType.value: dsParams.type.toData(),
                                              AWFeedbackParamsKey.tags.value: dsParams.source.toData()]
        if let brandId = dsParams.brandId {
            formDataParams.updateValue(dsParams.brandId!.toData(), forKey: AWFeedbackParamsKey.brandId.value)
        }
        formDataParams.updateValue(feedback.data(using: String.Encoding.utf8)!, forKey: "card_title")

        let body = createFormDataBody(formDataParam: formDataParams, boundary: boundary)
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Respones: \(response)")
            let hasValidData = (data != nil && error == nil)
            guard hasValidData,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    completion?(false)
                    return
            }
            completion?(true)
        }.resume()
    }
 }

extension Data {
    mutating func appendString(_ string: String) {
        guard let data = string.data(using: String.Encoding.utf8) else {
            print("Failed to append Data")
            return
        }
        append(data)
    }
}
