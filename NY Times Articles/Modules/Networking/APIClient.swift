//
//  APIClient.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation
import Alamofire

public typealias NetworkURLRequestConvertible = URLRequestConvertible
public typealias NetworkHTTPMethod = HTTPMethod

public protocol APIClient {
    func request(route: NetworkURLRequestConvertible, _ completion: @escaping (APIResponseConvertible?,NetworkErrors?) -> Void)
    func upload(documents: [DocumentDataConvertible],
                route: NetworkURLRequestConvertible,
                otherFormValues formValues: [String: String], _ completion: @escaping (APIResponseConvertible?,AFError?) -> Void, progress: @escaping (Progress) -> Void)
}
