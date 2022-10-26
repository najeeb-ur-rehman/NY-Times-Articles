//
//  BaseService.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation
import Alamofire

public typealias APIConfigProvider = BaseUrlProvider & APIKeyProvider

open class BaseService: Service {
    
    // MARK: Properties
    public let config: APIConfigProvider
    public let apiClient: APIClient
   
    // MARK: INITIALIZER
    public init(config: APIConfigProvider,
                apiClient: APIClient) {
        self.config = config
        self.apiClient = apiClient
    }

    // MARK: Helper Methods
    private var serverReadableDateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }

    private func decode<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(serverReadableDateTimeFormatter)
        return try decoder.decode(T.self, from: data)
    }
    
}

// MARK: Service Methods

extension BaseService {
    
    public func request<T: Codable>(apiClient: APIClient,
                                    route: NetworkURLRequestConvertible,
                                    _ completion: @escaping (Result<T,NetworkErrors>)  -> Void)  {
        
        apiClient.request(route: route) { response, error in
            guard let response = response ,  200...299 ~= (response.code) else {
                completion(.failure(NetworkErrorHandler.mapError(response?.code ?? 0 , data: response?.data ?? Data())))
                return
            }
            do {
                let object: T = try self.decode(data: response.data)
                completion(.success(object))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }
    }

    public func upload<T: Codable>(apiClient: APIClient,
                                   documents: [DocumentDataConvertible],
                                   route: NetworkURLRequestConvertible,
                                   otherFormValues formValues: [String: String],
                                   progressCompletion: @escaping (Progress) -> Void,
                                   _ completion: @escaping (Result<T,NetworkErrors>)  -> Void) {
        
        apiClient.upload(documents: documents, route: route, otherFormValues: formValues) { response, eror in
            guard let response = response ,  200...299 ~= (response.code) else {
                completion(.failure(NetworkErrorHandler.mapError(response?.code ?? 0 , data: response?.data ?? Data())))
                return
            }
            do {
                let object: T = try self.decode(data: response.data)
                completion(.success(object))
            } catch {
                completion(.failure(.decoding(error)))
            }
        } progress: { progress in
            progressCompletion(progress)
        }
    }
    
}
