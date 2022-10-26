//
//  APIConfiguration.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public protocol TrustEvaluatorProvider {
    var trustEvaluator: TrustEvaluatorType? { get }
}

public protocol BaseUrlProvider {
    var baseURL: URL { get }
}

public protocol APIKeyProvider {
    var apiKey: String? { get }
}

public struct APIConfiguration: BaseUrlProvider, TrustEvaluatorProvider, APIKeyProvider {
    
    public let trustEvaluator: TrustEvaluatorType?
    public let baseURL: URL
    public let apiKey: String?
    
    public init(baseURL: URL, apiKey: String? = nil, trustEvaluator: TrustEvaluatorType? = nil) {
        self.baseURL = baseURL
        self.trustEvaluator = trustEvaluator
        self.apiKey = apiKey
    }
    
}
