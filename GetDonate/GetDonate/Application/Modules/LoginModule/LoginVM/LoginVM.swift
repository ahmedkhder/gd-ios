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
        let params = [J_KEYS.kMOBILE: mobileNo.value]
        return RequestData(path: APIs.kSEND_OTP,
                           method: .post,
                           params: params,
                           headers: HEADER_NON_AUTH)
    }
    func requestLogin() {
        guard MyUtility.isNetworkAvailable else {
            AppDelegate.shared.topViewController().showPopup(message: .kOFFLINE) {}
            return
        }
        execute(request: dataRequest, onSuccess: { (json) in
            guard json.count > 0 else {
                self.onSuccess?(.failure(.parser(string: .kUNKOWN)))
                return
            }
            guard let code = json[J_KEYS.kCODE] as? Int, code == .CODE_200 else {
                if let msg = json[J_KEYS.kMSG] as? String {
                    self.onSuccess?(.failure(.parser(string: msg)))
                }
                return
            }
            guard let data = json[J_KEYS.kDATA] as? [String: Any] else {
                return
            }
            self.onSuccess?(.success(result: data))
            
        }, onError: { (error) in
            self.onSuccess?(.failure(.custom(string: .kUNKOWN)))
        })
    }
}
