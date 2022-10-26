//
//  APIEndpoint.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public struct APIEndpoint<Body: Codable>: Convertible, NetworkURLRequestConvertible {
    var method: NetworkHTTPMethod
    var url: URL
    var path: String
    var pathVariables: [String]?
    var query: [String: String]?
    var requestType: RequestType
    var body: Body?
    var headers: [String: String]

    public init(_ method: NetworkHTTPMethod, _ url: URL, _ path: String, pathVariables: [String]? = nil,
         query: [String: String]? = nil, requestType: RequestType = .json, body: Body? = nil,
         headers: [String: String] = [:]) {
        self.method = method
        self.url = url
        self.path = path
        self.pathVariables = pathVariables
        self.query = query
        self.requestType = requestType
        self.body = body
        self.headers = headers
    }

    public var authHeaders: [String: String] {
        return headers
    }

    public func asURLRequest() throws -> URLRequest {
        return try urlRequest(with: url, path: path, method: method, requestType: requestType,
                              input: (body: body, query: query, pathVariables: pathVariables, headers: headers))
    }
}

