//
//  Constants.swift
//  FullFeedback
//
//  Created by Sathish on 16/12/18.
//

import Foundation

// MARK: ModeType
enum TaskEnvironmentType: Int {
    case live
    case staging
}

var FullApiConstants: TaskApiConstants = TaskApiConstants(mode: .live) //Must be

// MARK: Constants
public struct TaskApiConstants {
	
	let dsTaskBaseUrl: String
	let awTaskBaseUrl: String
	var apiKey: String! // Main application should set this
	
	init(mode: TaskEnvironmentType) {
		switch mode {
			case .live:
				dsTaskBaseUrl = "https://my.distributedsource.com"
				awTaskBaseUrl = "https://api.anywhereworks.com"
			
			case .staging:
				dsTaskBaseUrl = "https://mystaging.distributedsource.com"
				awTaskBaseUrl = "https://api.staging.anywhereworks.com"
		}
	}
	
	public mutating func add(apiKey: String) {
		self.apiKey = apiKey
	}
}

// MARK: ERROR
public enum DSTaskError: Error {
    
    case invalidURL(String)
    case invalidParam(String)
        
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

// MARK: Choose App Type
public enum AppType {
    
    case dsTask
    case awFeedback
}


// MARK: Extension For .utf8 conversion
extension String {    
    func toData() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

public struct FullTaskLogger {
	public static let canLog: Bool = false
}

struct FullTaskUtils {
	static func getBundle() -> Bundle {
		let podBundle = Bundle(for: FeedbackViewController.self)
		guard let bundleUrl = podBundle.url(forResource: "FullFeedback", withExtension: "bundle") else { fatalError("FullFeedback bundle url not found") }
		guard let bundle = Bundle(url: bundleUrl) else { fatalError("FullFeedback bundle not found") }
		return bundle
	}
}

let fullTaskLogTag = "[FullTask]:"

func fullTaskLogMessage(_ string: String) {
	guard FullTaskLogger.canLog else { return }
	print("💙💙 \(fullTaskLogTag) \(string)")
}

func fullTaskLogError(_ error: Error) {
	guard FullTaskLogger.canLog else { return }
	print("♥️♥️ \(fullTaskLogTag) \(error.localizedDescription)")
}

func fullTaskLogError(_ error: String) {
	guard FullTaskLogger.canLog else { return }
	print("♥️♥️ \(fullTaskLogTag) \(error)")
}
