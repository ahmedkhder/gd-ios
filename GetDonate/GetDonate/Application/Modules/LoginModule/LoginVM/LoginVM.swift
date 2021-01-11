//
//  LoginVM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 05/01/21.
//

import Foundation
import UIKit

private protocol LoginVMDelegate {
    var mobileNo: Observer<String> { get set }
//    var arrayData: Observer<[[String: Any]]>{ get set }
}

class LoginVM: NSObject, LoginVMDelegate {
//    var arrayData: Observer<[[String : Any]]>
    var mobileNo: Observer<String> {
        didSet {
            self.emitValidity()
        }
    }
    var isValidListener: ((Bool) -> ())?
    
    override init() {
        self.mobileNo = Observer(.kEMPTY)
//        self.arrayData = Observer([])
    }
}
//MARK: Configuration
extension LoginVM {
    //Hook Validate Listener
    func emitValidity() {
        let isValid = mobileNo.value.isEmpty != true &&
                      mobileNo.value.count >= 1
        self.isValidListener?(isValid)
//        self.arrayData.value = [["Shiv":"kumar"], ["Shiv":"kumar"]]
    }
}
extension LoginVM {
    
}

