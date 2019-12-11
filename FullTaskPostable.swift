//
//  FullTaskPostable.swift
//  FullFeedback
//

import Foundation

protocol FullTaskPostable {
	var param: TaskParam { get }
	var content: TaskContent { get }
	func postFeedback(completion: TaskCompletion?) throws
}

extension FullTaskPostable {
	
	func validateParams() throws {
		try validate(param: param.department, of: .department)
		try validate(brandId: param.brandId)
		try validate(param: param.source, of: .source)
		try validate(param: param.type, of: .type)
		try validate(param: param.accessToken, of: .accessToken)
	}
	
	func validate(param: String, of type: ErrorValidatorType) throws {
		guard !param.isEmpty else {
			throw DSTaskError.invalidParam("Invalid \(type.rawValue)")
		}
	}
	
	func validate(brandId: String?) throws {
		if let id = brandId, id.isEmpty {
			throw DSTaskError.invalidParam("Invalid BrandId")
		}
	}
}
