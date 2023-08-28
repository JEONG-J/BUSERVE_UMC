//
//  UserInfo.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/21.
//

import Foundation

struct UserInfo: Codable {
    let name: String // 유저 이름
    let email: String // 유저 이메일
    let socialLoginType: String // 유저 인증을 위한 Token
}
