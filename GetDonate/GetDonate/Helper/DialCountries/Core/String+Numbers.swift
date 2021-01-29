//
//  String+Numbers.swift
//  DialCountries
//
//  Created by Shiva Kr. on 03/11/20.
//  Copyright © 2020 spice africa. All rights reserved.
//

import Foundation

extension String {
	
	func toEnglishNumber() -> String {
		let numberFormatter = NumberFormatter()
		numberFormatter.locale = Locale(identifier: "EN")
		guard let result = numberFormatter.number(from: self) else {
			
			return self
		}
		return result.stringValue
	}
}
