//
//  HTTPRequestData.swift
//
//  Created by JMD on 29/01/20.
//  Copyright © 2020 JMD. All rights reserved.
//

import Foundation

//MARK: Data Request
public struct RequestData {

    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    
    public init (path: String,
                 method: HTTPMethod = .get,
                 params: [String: Any?]? = nil,
                 headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}

