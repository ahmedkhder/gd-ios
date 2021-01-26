//
//  GDFont.swift
//  GetDonate
//
//  Created by Shiva Kr. on 25/01/21.
//

import Foundation
import UIKit

enum Font: String {
    case Bold = "Roboto-Bold"
    case Light = "Roboto-Light"
    case Medium = "Roboto-Medium"
    case Regular = "Roboto-Regular"
    case SemiBold = "Roboto-SemiBold"
    
    func of(size : CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
