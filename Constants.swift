//
//  Constants.swift
//  FullFeedback
//
//  Created by Sathish on 16/12/18.
//

import Foundation

// MARK: ModeType
enum DSTaskModeType: Int {
    case live
    case staging
}

private let dsTaskMode: DSTaskModeType = .live

let Constants = ConstantsStruct(mode: dsTaskMode)

// MARK: Constants
struct ConstantsStruct {
    
    let urlStr: String
    let apiKey: String
    
    init(mode: DSTaskModeType) {
        
        switch mode {
        case .live:
            urlStr = "https://my.distributedsource.com"
            apiKey = "SEN42"
        case .staging:
            urlStr = "https://mystaging.distributedsource.com"
            apiKey = "SEN42"
        }
    }
}

// MARK: ERROR
public enum DSTaskError: Error {
    
    case invalidURL(String)
    case invalidParam(String)
    
//    case invalidDepartment
//    case invalidDepartmentId
//    case invalidBrandId
//
//    case invalidType
//    case invalidSource
//
//    case invalidAccessToken
//    case invalidEmailId
    
    public var description: String {
        
        switch self {
        case .invalidURL(let error):
            return error.description
        case .invalidParam(let error):
            return error.description
        default:
            return self.localizedDescription
        }
    }
}

// MARK: ErrorValidator Type
enum ErrorValidatorType: String {
    
    case department = "Department"
    case departmentId = "DepartmentID"
    case brandId = "BrandID"
    case type = "Type"
    case source = "Source"
    case accessToken = "AccessToken"
    case emailId = "EmailID"
}
