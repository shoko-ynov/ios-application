//
//  AuthenticationManager.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 19/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

class AuthenticationManager {
    
    static func setToken(token: Token) {
        UserDefaults.standard.set(token.refreshToken, forKey: "REFRESH_TOKEN")
        UserDefaults.standard.set(token.token, forKey: "TOKEN")
    }
    
    static func hasToken() -> Bool {
        let token = UserDefaults.standard.string(forKey: "REFRESH_TOKEN")
        let refreshToken = UserDefaults.standard.string(forKey: "TOKEN")
        
        guard let _ = token, let _ = refreshToken else {
            return false
        }
        
        return true
    }
    
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "REFRESH_TOKEN")
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "TOKEN")
    }
    
    static func removeTokens() -> Void {
        UserDefaults.standard.removeObject(forKey: "TOKEN")
        UserDefaults.standard.removeObject(forKey: "REFRESH_TOKEN")
    }
}
