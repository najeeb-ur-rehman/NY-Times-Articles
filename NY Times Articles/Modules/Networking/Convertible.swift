//
//  Convertible.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public protocol Convertible {

    func urlRequest<T: Codable>(with url: URL, path: String, method: NetworkHTTPMethod, requestType: RequestType, input: RouterInput<T>?) throws -> URLRequest

    var authHeaders: [String: String] { get }
}

public extension Convertible {

    func urlRequest<T: Codable>(with url: URL, path: String, method: NetworkHTTPMethod, requestType: RequestType = .json, input: RouterInput<T>?) throws -> URLRequest {

        let url = try constructAPIUrl(with: url, path: path, input: input)
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        let requestTypeHeaders = requestType.requestHeaders
        for (key, value) in requestTypeHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        for (key, value) in authHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        if let parameters = input?.body {
            urlRequest.httpBody = Data()
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .millisecondsSince1970
                urlRequest.httpBody = try encoder.encode(parameters)
            } catch {
                throw error
            }
        }

        return urlRequest
    }

    private func constructAPIUrl<T: Codable>(with url: URL, path: String, input: RouterInput<T>?) throws -> URL {

        guard let `input` = input else { return url.appendingPathComponent(path) }

        var constructedURL = url.appendingPathComponent(path)

        if let pathVariables = input.pathVariables {
            for pathVariable in pathVariables {
                constructedURL.appendPathComponent(pathVariable)
            }
        }

        if let query = input.query {
            var components = URLComponents(string: constructedURL.absoluteString)!
            var queryItems = [URLQueryItem]()
            for (key, value) in query {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems
            return components.url!
        }

        return constructedURL
    }
}
