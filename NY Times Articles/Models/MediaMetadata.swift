//
//  MediaMetadata.swift
//  NY Times Articles
//
//  Created by Najeeb on 27/10/2022.
//

import Foundation

struct MediaMetadata : Codable {
    let url : URL?
    let format : String?
    let height : Int?
    let width : Int?
}
