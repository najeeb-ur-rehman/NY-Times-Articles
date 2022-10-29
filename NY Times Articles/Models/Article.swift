//
//  Article.swift
//  NY Times Articles
//
//  Created by Najeeb on 27/10/2022.
//

import Foundation

struct Article: Codable {
    var articleUrl: String?
    var title: String
    var authorName: String
    var publishedDate: String
    var media: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case articleUrl = "url"
        case title
        case authorName = "byline"
        case publishedDate = "published_date"
        case media
    }
    
}
