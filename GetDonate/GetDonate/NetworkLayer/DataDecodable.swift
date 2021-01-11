//
//  DataDecode.swift
//
//  Created by JMD on 11/09/19.
//  Copyright © 2019 JMD All rights reserved.
//

import Foundation

///- MARK: Data Decodable
extension Data {
    func decode<T>(model: T.Type) throws -> T? where T : Decodable {
        if let modelDecodable = try? model.init(jsonData: self) {
            return modelDecodable
        }
        return nil
    }
}

extension Decodable {
    init(jsonData: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: jsonData)
    }
}
