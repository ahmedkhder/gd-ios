//
//  Result.swift
//
//  Created by JMD on 18/08/19.
//  Copyright © 2019 JMD. All rights reserved.
//

import Foundation

/// - NOTE: Hookup response
typealias ResponseNotify = ((Result<Codable, ErrorResult>)->())?
typealias OnSuccess = ((Result<[String: Any]?, ErrorResult>)->())?
typealias SelectedListener <T> = ((Int, T?)->())?
typealias ValidateListner = ((Bool) -> ())?

public enum Result<T, E: Error> {
    case success(result: T)
    case failure(E?)
}

public enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

public enum ErrorType: Swift.Error {
    case invalidURL
    case noData
}
