//
//  GDParseData.swift
//  GetDonate
//
//  Created by Shiva Kr. on 31/01/21.
//

import Foundation

struct UserInfo {
    static func getUserInfo()-> LoginData? {
        guard let userInfo = NSUserDefaults.value(LoginData.self, forKey: .LOGIN_INFO) else { return nil }
        return userInfo
    }
    static func getUserId() -> String? {
        guard let info = getUserInfo(),
              let user_Id = info.id else { return .kEMPTY }
        return "\(user_Id)"
    }
    static func getUserToken() -> String? {
        guard let info = getUserInfo(),
              let user_Token = info.token else { return .kEMPTY }
        return "\(user_Token)"
    }
}
