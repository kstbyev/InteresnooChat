//
//  AppLaunchStorage.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class AppLaunchStorage {
    private let key = "has_seen_onboarding"

    var hasSeenOnboarding: Bool {
        UserDefaults.standard.bool(forKey: key)
    }

    func markSeen() {
        UserDefaults.standard.set(true, forKey: key)
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
