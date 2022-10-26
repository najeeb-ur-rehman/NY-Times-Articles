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
        let urlRequest = route.urlRequest
        var requestUrl = ""
        if let url = urlRequest?.url?.absoluteString {
            requestUrl = url + " -> " + (String(data: urlRequest?.httpBody ?? Data(), encoding: .utf8) ?? "Failed to Convert")
            #if DEBUG
            print("Initiating request: \(requestUrl)")
            print("HEADERS")
            urlRequest?.allHTTPHeaderFields?.forEach { print("\($0.key) : \($0.value)") }
            #endif
        }
        
        session.request(route).validate().responseData(completionHandler: {  response in
            response.data.map { String(data: $0, encoding: .utf8 ).map {
                print("Response for : \(requestUrl)" + "\n" + $0) }
            }
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
        let urlRequest = route.urlRequest
        if let url = urlRequest?.url?.absoluteString {
            print(url + " -> " + (String(data: urlRequest?.httpBody ?? Data(), encoding: .utf8) ?? "Failed to Convert"))
        }
        
        session.upload(multipartFormData: {  multipartFormData in
            documents.forEach { multipartFormData.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType) }

            formValues.forEach { multipartFormData.append($0.value.data(using: .utf8) ?? Data(), withName: $0.key) }
        }, with: route).uploadProgress(closure: { progress in
            completionProgress(progress)
        }).response { response in

            guard response.error == nil else {
                completion(nil,response.error)
                return
                
            }
            print(String(data: response.data!, encoding: .utf8 )!)
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
