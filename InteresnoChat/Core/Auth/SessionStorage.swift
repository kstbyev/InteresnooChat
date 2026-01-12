//
//  SessionStorage.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class SessionStorage {
    private let key = "session_id"
    
    var sessionId: String? {
        UserDefaults.standard.string(forKey: key)
    }
    
    func save(_ id: String) {
        UserDefaults.standard.set(id, forKey: key)
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

