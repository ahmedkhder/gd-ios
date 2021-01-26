//
//  DonationVM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 13/01/21.
//

import UIKit

private protocol DonationVMDelegate {
    var cardNo: Observer<String> { get set }
    var expDate: Observer<String> { get set }
    var cvv: Observer<String> { get set }
    var name: Observer<String> { get set }
}

class DonationVM: NSObject, DonationVMDelegate {
    var cardNo: Observer<String> {
        didSet {
            self.emitValidity()
        }
    }
    var expDate: Observer<String> {
        didSet {
            self.emitValidity()
        }
    }
    var cvv: Observer<String> {
        didSet {
            self.emitValidity()
        }
    }
    var name: Observer<String> {
        didSet {
            self.emitValidity()
        }
    }
    var isValidListener: ((Bool) -> ())?
    
    override init() {
        self.cvv = Observer(.kEMPTY)
        self.name = Observer(.kEMPTY)
        self.cardNo = Observer(.kEMPTY)
        self.expDate = Observer(.kEMPTY)
    }
}
//MARK: Configuration
extension DonationVM {
    //Hook Validate Listener
    func emitValidity() {
        let isValid = cardNo.value.isEmpty != true &&
            expDate.value.count > 4  &&
            cvv.value.count > 2 &&
            name.value.isEmpty != true
        self.isValidListener?(isValid)
    }
    
}


