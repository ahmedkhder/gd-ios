//
//  Observer.swift
//  Observer
//
//  Created by Shiva Kr. on 29/12/20.
//  Copyright © 2020 Shiva Kr. All rights reserved.
//

import Foundation

final class Observer<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
