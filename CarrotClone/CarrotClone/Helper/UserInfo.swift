//
//  UserInfo.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/08.
//

import Foundation

struct UserInfo {
    public static let shared = UserInfo()
    private init() {}
    
    private var name = "jason"
    
    public func getUserName() -> String {
        return name
    }
}
