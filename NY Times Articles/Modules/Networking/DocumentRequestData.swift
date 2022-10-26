//
//  DocumentRequestData.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public struct DocumentRequestData: DocumentDataConvertible {
    public var data: Data
    public var name: String
    public var fileName: String
    public var mimeType: String
}
