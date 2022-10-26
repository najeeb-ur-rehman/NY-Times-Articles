//
//  RequestType.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public typealias RouterInput<T> = (body: T?, query: [String: String]?, pathVariables: [String]?, headers: [String: String]?)

public enum RequestType: Int {
    case json
    case formData
}

public extension RequestType {
    var requestHeaders: [String: String] {
        var headers = [String: String]()
        switch self {
        case .json:
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"
        case .formData:
            headers["Content-type"] = "multipart/form-data"
            headers["Accept"] = "application/json"
        }
        return headers
    }
}
