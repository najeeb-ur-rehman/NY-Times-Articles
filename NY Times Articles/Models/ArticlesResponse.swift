//
//  ArticlesResponse.swift
//  NY Times Articles
//
//  Created by Najeeb on 27/10/2022.
//

import Foundation

struct ArticlesResponse: Codable {
    let status : String?
    let results: [Article]?
    let number: Int?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
        case number = "num_results"
        case copyright = "copyright"
    }
}
