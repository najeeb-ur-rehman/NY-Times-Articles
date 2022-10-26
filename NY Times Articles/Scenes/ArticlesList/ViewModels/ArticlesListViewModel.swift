//
//  ArticlesListViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
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

struct Media: Codable {
    let type: String?
    let metadata: [MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case metadata = "media-metadata"
    }
    
    var articlePosterURL: URL? {
        var url: URL?
        if (metadata?.count ?? 0) > 1 {
            url = metadata?[1].url
        } else if metadata?.count == 1 {
            url = metadata?[0].url
        }
        return url
    }
}

struct MediaMetadata : Codable {
    let url : URL?
    let format : String?
    let height : Int?
    let width : Int?
}

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


class ArticlesListViewModel {
    
    var articlesList: [Article] = []
    
    
    func fetchArtciles(_ completion: @escaping ([Article]?) -> ()) {
        let config = APIConfiguration(baseURL: URL(string: "https://api.nytimes.com")!, apiKey: "jABQK7KhauIOLisCnlYjh1uBqGMgUXAA")
        let client = WebClient(config: config)
        let service = ArticleService(config: config, apiClient: client)
        
        service.getArticles { (result: Result<ArticlesResponse, NetworkErrors>) in
            dump(result)
        }
    }
}
