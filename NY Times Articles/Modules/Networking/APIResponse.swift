//
//  APIResponse.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Foundation


public struct APIResponse: APIResponseConvertible {
    public let code: Int
    public let data: Data

    public init(code: Int, data: Data) {
        self.code = code
        self.data = data
    }
}
