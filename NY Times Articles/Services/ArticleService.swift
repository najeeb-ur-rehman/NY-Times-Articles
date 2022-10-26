//
//  ArticleService.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

protocol ArticleServiceType {
    func getArticles<T: Codable>(_ completion: @escaping (Result<T, NetworkErrors>) -> Void )
}

class ArticleService: BaseService, ArticleServiceType {
    
    func getArticles<T: Codable>(_ completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        var query = [String: String]()
        if let apiKey = config.apiKey {
            query["api-key"] = apiKey
        }
        let route = APIEndpoint<String>(.get, config.baseURL, "/svc/mostpopular/v2/viewed/7.json", query: query)
        request(apiClient: apiClient, route: route, completion)
    }
    
}
