//
//  Media.swift
//  NY Times Articles
//
//  Created by Najeeb on 27/10/2022.
//

import Foundation

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
