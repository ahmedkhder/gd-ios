//
//  DataType+Ext.swift
//  BOCUser
//
//  Created by JMD on 20/12/20.
//

import Foundation

extension Double {
    func to2PlaceString() -> String {
        String(format: "%.02f", self)
    }
    func toString()-> String {
        "\(self)"
    }
}
extension Int {
    func toString() -> String {
        "\(self)"
    }
}
