//
//  Constants.swift
//  GetDonate
//
//  Created by JMD on 05/01/21.
//

import Foundation
import UIKit

let DEVICE_TOKEN = "DEVICE_TOKEN"
// MARK: These are Keybaord Hide/Show keys
struct Keyboard {
    static let willShow = UIResponder.keyboardWillShowNotification
    static let willHide = UIResponder.keyboardWillHideNotification
}

//MARK: Json Keys
struct JKeys {
    
}

///- Return:  Default Country code
func get_Country_Code()-> String {
    if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
        Log.print(countryCode)
        return countryCode
    }
    return .kEMPTY
}
