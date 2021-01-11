//
//  GDColor.swift
//  GetDonate
//
//  Created by JMD on 05/01/21.
//

import Foundation
import UIKit

struct Color {
    static var placeholder: UIColor {
        return UIColor.white.withAlphaComponent(0.5)
    }
    static var txtFieldBorderColor: UIColor {
        return UIColor.lightGray.withAlphaComponent(0.5)
    }
    static var navColor: UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    static var darkGray: UIColor {
        return .color(hexString: "797979")
    }
    static var blueTheme: UIColor {
        return .color(hexString: "009fdd")
    }
}
