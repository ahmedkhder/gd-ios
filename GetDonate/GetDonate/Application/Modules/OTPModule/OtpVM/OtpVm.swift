//
//  OtpVm.swift
//  GetDonate
//
//  Created by Shiva Kr. on 09/01/21.
//

import UIKit

private protocol OtpVMDelegate {
    var otpString: String { get set }
}

class OtpVM: NSObject, OtpVMDelegate {
    fileprivate var otpString: String = .kEMPTY
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

