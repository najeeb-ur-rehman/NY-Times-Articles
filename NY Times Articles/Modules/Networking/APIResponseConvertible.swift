//
//  APIResponseConvertible.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation

public protocol APIResponseConvertible: Codable {
    var code: Int { get }
    var data: Data { get }
}
