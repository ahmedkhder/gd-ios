//
//  LoginM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 31/01/21.
//

import Foundation

struct LoginM {
    let status : Bool?
    let code : Int?
    let message : String?
    let data : LoginData?
    
    init(json: [String: Any]) {
        self.status = json["status"] as? Bool
        self.code = json["code"] as? Int
        self.message = json["message"] as? String
        let jsonData = json["data"] as? [String : Any]
        self.data = LoginData(json: jsonData ?? [:])
    }
}

struct LoginData: Codable {
    let id: Int?
    let email: String?
    let token: String?
    init(json: [String: Any]) {
        self.id = json["id"] as? Int
        self.email = json["email"] as? String
        self.token = json["token"] as? String
    }
}
