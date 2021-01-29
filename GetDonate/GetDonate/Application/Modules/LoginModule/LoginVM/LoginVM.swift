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
    var countryCode: Observer<String> { get set }
//    var arrayData: Observer<[[String: Any]]>{ get set }
}

class LoginVM: NSObject, LoginVMDelegate {
    //    var arrayData: Observer<[[String : Any]]>
    var countryCode: Observer<String> {
        didSet { self.emitValidity() }
    }
    var mobileNo: Observer<String>  {
        didSet { self.emitValidity() }
    }
    var isValidListener: ValidateListner = nil
    var onSuccess: OnSuccess = nil
    
    //Initiallation
    override init() {
        self.countryCode = Observer(.kEMPTY)
        self.mobileNo = Observer(.kEMPTY)
//        self.arrayData = Observer([])
    }
}
//MARK: Configuration
extension LoginVM {
    //Hook Validate Listener
    func emitValidity() {
        let isValid = mobileNo.value.isEmpty != true &&
                      mobileNo.value.count >= 1 &&
                      countryCode.value.isEmpty != true
        self.isValidListener?(isValid)
//        self.arrayData.value = [["Shiv":"kumar"], ["Shiv":"kumar"]]
    }
}

extension LoginVM: DataRequest {
    var dataRequest: RequestData {
        return RequestData(path: "",
                           method: .post,
                           params: [:], headers: [:])
    }
    func requestLogin() {
        guard MyUtility.isNetworkAvailable else {
            AppDelegate.shared.topViewController().showPopup(message: .kOFFLINE) {}
            return
        }
        execute(request: dataRequest, onSuccess: { (json) in
            if json.count > 0 {
                self.onSuccess?(Result.success(result: json))
            } else {
                self.onSuccess?(Result.failure(.parser(string: .kUNKOWN)))
            }
        }, onError: { (error) in
            self.onSuccess?(Result.failure(.custom(string: .kUNKOWN)))
        })
    }
}
