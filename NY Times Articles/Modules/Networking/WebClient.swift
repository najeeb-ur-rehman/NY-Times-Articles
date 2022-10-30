//
//  WebClient.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation
import Alamofire

public typealias WebClientConfigurable = BaseUrlProvider & TrustEvaluatorProvider

public class WebClient: APIClient {
    
    private var session: Alamofire.Session

    public init(config: WebClientConfigurable) {
        let serverTrustManager = config.trustEvaluator?.evaluator.map {
            ServerTrustManager(evaluators: [config.baseURL.host ?? config.baseURL.absoluteString: $0])
        }
        session = Alamofire.Session(configuration: URLSessionConfiguration.default,
                                    serverTrustManager: serverTrustManager)
        
    }
    
    public func request(route: NetworkURLRequestConvertible,
                        _ completion: @escaping (APIResponseConvertible?, NetworkErrors?) -> Void) {
        session.request(route).validate().responseData(completionHandler: {  response in
            if response.error != nil {
                let code = response.response?.statusCode ?? ((response.error!) as NSError).code
                let errorData = response.data ?? Data()
                let apiResponse = APIResponse(code: code, data: errorData)
                completion(apiResponse,nil)
            } else {
                let code = response.response?.statusCode ?? 200
                let data = response.data ?? Data()
                let apiResponse = APIResponse(code: code, data: data)
                completion(apiResponse, nil)
            }
        })
    }

    public func upload(documents: [DocumentDataConvertible],
                       route: NetworkURLRequestConvertible,
                       otherFormValues formValues: [String: String], _ completion: @escaping (APIResponseConvertible?,AFError?) -> Void, progress completionProgress: @escaping (Progress) -> Void)
    {
        
        session.upload(multipartFormData: {  multipartFormData in
            documents.forEach { multipartFormData.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType) }

            formValues.forEach { multipartFormData.append($0.value.data(using: .utf8) ?? Data(), withName: $0.key) }
        }, with: route).uploadProgress(closure: { progress in
            completionProgress(progress)
        }).response { response in

            guard response.error == nil else {
                completion(nil, response.error)
                return
                
            }
            if response.error != nil {
                let code = response.response?.statusCode ?? ((response.error!) as NSError).code
                let errorData = response.data ?? Data()
                let apiResponse = APIResponse(code: code, data: errorData)
                completion(apiResponse, nil)
            } else {
                let code = response.response?.statusCode ?? 200
                let data = response.data ?? Data()
                let apiResponse = APIResponse(code: code, data: data)
                completion(apiResponse, nil)
            }
        }
    }
}
