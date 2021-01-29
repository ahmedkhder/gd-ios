//
//  CountriesFetcher.swift
//  DialCountries
//
//  Created by Shiva Kr. on 03/11/20.
//  Copyright © 2020 spice africa. All rights reserved.
//

import Foundation

class CountriesFetcher {
	
	func fetch() -> [Country] {
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json") {
            let data = try! Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let countries = try! decoder.decode([Country].self, from: data)
            
            return countries
        }
        return []
	}
}
