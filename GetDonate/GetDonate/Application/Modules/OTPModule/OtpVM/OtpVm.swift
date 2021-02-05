//
//  OtpVm.swift
//  GetDonate
//
//  Created by Shiva Kr. on 09/01/21.
//

import UIKit

private protocol OtpVMDelegate {
    var otpString: String { get set }
    var mobileString: String { get set }
}

class OtpVM: NSObject, OtpVMDelegate {
    fileprivate var otpString: String = .kEMPTY
    var mobileString: String = .kEMPTY
    var onSuccess: OnSuccess = nil
}

//MARK: Configuration
extension OtpVM {
    func setOTP(_ otp: Observer<String>) {
        otp.bindAndFire {
            self.otpString = $0
            Log.print("OTP String ====>", self.otpString)
        }
    }
}
//MARK: ====> API Caling <====
extension OtpVM: DataRequest {
    var dataRequest: RequestData {
        let params = [J_KEYS.kPHONE: mobileString,
                      J_KEYS.kOTP: self.otpString]
        return RequestData(path: APIs.kVERIFY_OTP,
                           method: .post,
                           params: params,
                           headers: HEADER_NON_AUTH)
    }
    func requestVerifyOTP() {
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
            //Save Data into Local DB
            let loginM = LoginM(json: json)
            NSUserDefaults.set(encodable: loginM.data, forKey: .LOGIN_INFO)
            
            self.onSuccess?(.success(result: data))
            
        }, onError: { (error) in
            self.onSuccess?(.failure(.custom(string: .kUNKOWN)))
        })
    }
}
