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
        let params = [J_KEYS.kEMAIL: "test1@gmail.com", J_KEYS.kPASSWORD: "12345"]
        return RequestData(path: APIs.kLOGIN,
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
            let loginM = LoginM(json: json)
            NSUserDefaults.set(encodable: loginM.data, forKey: .LOGIN_INFO)
            self.onSuccess?(.success(result: data))
            
        }, onError: { (error) in
            self.onSuccess?(.failure(.custom(string: .kUNKOWN)))
        })
    }
}
/*
 {
     "status": true,
     "code": 200,
     "message": "success",
     "data": {
         "id": 3,
         "email": "test1@gmail.com",
         "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjMsImFsZyI6IlJTMjU2IiwiaXNzIjoiYWRtaW5AZ2QuY29tIiwic3ViIjoiYWRtaW5AZ2QuY29tIiwiYXVkIjoiaHR0cHM6Ly9pZGVudGl0eXRvb2xraXQuZ29vZ2xlYXBpcy5jb20vZ29vZ2xlLmlkZW50aXR5LmlkZW50aXR5dG9vbGtpdC52MS5JZGVudGl0eVRvb2xraXQiLCJpYXQiOjE2MTIwOTU0NTgsImV4cCI6MTY3NTE2NzQ1OCwiaXNfYWRtaW4iOnRydWUsImlzX3VzZXIiOmZhbHNlfQ.6yGnlVBABOcgm0-aP9l6AhSITdVdds_UWEWvIHbvo-4"
     }
 }
 =======
 {
     "code": 400,
     "isError": true,
     "status": "Bad Request",
     "message": "error user not found",
     "data": null
 }
 */
