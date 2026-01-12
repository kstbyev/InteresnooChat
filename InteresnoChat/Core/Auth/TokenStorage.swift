//
//  TokenStorage.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class TokenStorage {
    
    private let accessKey = "access_token"
    private let refreshKey = "refresh_token"
    
    var hasAccessToken: Bool {
        Keychain.get(accessKey) != nil
    }
    
    func save(_ tokens: AuthTokens) {
        Keychain.set(tokens.access_token, forKey: accessKey)
        Keychain.set(tokens.refresh_token, forKey: refreshKey)
    }
    
    func accessToken() -> String? {
        Keychain.get(accessKey)
    }
    
    func refreshToken() -> String? {
        Keychain.get(refreshKey)
    }
    
    func clear() {
        Keychain.remove(accessKey)
        Keychain.remove(refreshKey)
    }
}
