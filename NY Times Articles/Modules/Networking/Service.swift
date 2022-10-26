//
//  Service.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public protocol Service {
    
    func request<T: Codable>(apiClient: APIClient,
                             route: NetworkURLRequestConvertible,
                             _ completion: @escaping (Result<T,NetworkErrors>) -> Void)
    
    func upload<T: Codable>(apiClient: APIClient,
                            documents: [DocumentDataConvertible],
                            route: NetworkURLRequestConvertible,
                            otherFormValues formValues: [String: String],
                            progressCompletion: @escaping (Progress) -> Void,
                            _ completion: @escaping (Result<T,NetworkErrors>)  -> Void)
}

