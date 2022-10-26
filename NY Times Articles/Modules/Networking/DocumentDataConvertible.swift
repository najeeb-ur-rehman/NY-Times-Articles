//
//  DocumentDataConvertible.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public protocol DocumentDataConvertible: Codable {
    var data: Data { get }
    var name: String { get }
    var fileName: String { get }
    var mimeType: String { get }
}
